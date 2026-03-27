import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/utils.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<DocumentSnapshot>? _orderSubscription;

  LatLng _riderPosition = const LatLng(31.5204, 74.3587);
  LatLng _userHome = const LatLng(31.5204, 74.3587);
  static const LatLng _storeLocation = LatLng(31.5204, 74.3587);

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _listenToOrderUpdates();
  }

  @override
  void dispose() {
    _orderSubscription?.cancel();
    super.dispose();
  }

  void _fitBounds(GoogleMapController controller, LatLng p1, LatLng p2) {
    LatLngBounds bounds;
    if (p1.latitude > p2.latitude) {
      bounds = LatLngBounds(southwest: p2, northeast: p1);
    } else {
      bounds = LatLngBounds(southwest: p1, northeast: p2);
    }
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  void _listenToOrderUpdates() {
    _orderSubscription = FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        if (data['status'] == "Delivered") {
          if (mounted) Get.back();
          return;
        }

        double uLat = (data['userLatitude'] as num).toDouble();
        double uLng = (data['userLongitude'] as num).toDouble();
        double rLat = (data['riderLatitude'] as num).toDouble();
        double rLng = (data['riderLongitude'] as num).toDouble();

        LatLng newRiderPos = LatLng(rLat, rLng);
        LatLng newUserHome = LatLng(uLat, uLng);
        if (!_isInitialized) {
          setState(() {
            _userHome = newUserHome;
            _riderPosition = newRiderPos;
            _isInitialized = true;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final GoogleMapController controller = await _controller.future;
            _fitBounds(controller, newRiderPos, newUserHome);
          });
        } else {
          setState(() {
            _riderPosition = newRiderPos;
          });

          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: newRiderPos, zoom: 16.0),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking Order",
            style: TextStyle(fontFamily: "Gilroy", fontWeight: FontWeight.bold, fontSize: 18.sp)),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: !_isInitialized
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _riderPosition, zoom: 15),
            onMapCreated: (controller) => _controller.complete(controller),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                points: [_riderPosition, _userHome],
                color: AppColors.primaryColor,
                width: 4,
                jointType: JointType.round,
              ),
            },
            markers: {
              Marker(
                markerId: const MarkerId("store"),
                position: _storeLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                infoWindow: const InfoWindow(title: "Store"),
              ),
              Marker(
                markerId: const MarkerId("home"),
                position: _userHome,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: const InfoWindow(title: "Your Home"),
              ),
              Marker(
                markerId: const MarkerId("rider"),
                position: _riderPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                infoWindow: const InfoWindow(title: "Rider"),
              ),
            },
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: _buildRiderInfoCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildRiderInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange.withValues(alpha: 0.1),
            child: const Icon(Icons.delivery_dining, color: Colors.orange),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Rider is on the way!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, fontFamily: "Gilroy")),
              Text("Arriving at your location soon",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp, fontFamily: "Gilroy")),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map_animations/flutter_map_animations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart' as osm;
// import '../components/utils.dart';
// import 'dart:math' as math;
//
// class OrderTrackingScreen extends StatefulWidget {
//   final String orderId;
//   const OrderTrackingScreen({super.key, required this.orderId});
//
//   @override
//   State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
// }
//
// class _OrderTrackingScreenState extends State<OrderTrackingScreen>
//     with TickerProviderStateMixin {
//   late final _animatedMapController = AnimatedMapController(vsync: this);
//   StreamSubscription<DocumentSnapshot>? _orderSubscription;
//   final osm.LatLng _storeLocation = const osm.LatLng(31.5204, 74.3587);
//   osm.LatLng _userHome = const osm.LatLng(31.5204, 74.3587);
//   osm.LatLng _riderPosition = const osm.LatLng(31.5204, 74.3587);
//   bool _isInitialized = false;
//   @override
//   void initState() {
//     super.initState();
//     _listenToOrderUpdates();
//   }
//
//   @override
//   void dispose() {
//     _orderSubscription?.cancel();
//     _animatedMapController.dispose();
//     super.dispose();
//   }
//
//   double _riderRotation = 0.0;
//   double calculateBearing(osm.LatLng start, osm.LatLng end) {
//     double lat1 = start.latitude * math.pi / 180;
//     double lon1 = start.longitude * math.pi / 180;
//     double lat2 = end.latitude * math.pi / 180;
//     double lon2 = end.longitude * math.pi / 180;
//
//     double dLon = lon2 - lon1;
//     double y = math.sin(dLon) * math.cos(lat2);
//     double x =
//         math.cos(lat1) * math.sin(lat2) -
//         math.sin(lat1) * math.cos(lat2) * math.cos(dLon);
//
//     double radians = math.atan2(y, x);
//     return (radians * 180 / math.pi + 360) % 360;
//   }
//
//   void _listenToOrderUpdates() {
//     _orderSubscription = FirebaseFirestore.instance
//         .collection('orders')
//         .doc(widget.orderId)
//         .snapshots()
//         .listen((snapshot) async {
//           if (snapshot.exists) {
//             var data = snapshot.data() as Map<String, dynamic>;
//             debugPrint("New Data Received: Lat ${data['riderLatitude']}");
//             if (data['status'] == "Delivered") {
//               if (mounted) Get.back();
//               return;
//             }
//             double uLat = (data['userLatitude'] as num).toDouble();
//             double uLng = (data['userLongitude'] as num).toDouble();
//             double rLat = (data['riderLatitude'] as num).toDouble();
//             double rLng = (data['riderLongitude'] as num).toDouble();
//             if (uLat == rLat && uLng == rLng) {
//               rLat = rLat + 0.005;
//               rLng = rLng + 0.005;
//             }
//
//             osm.LatLng newRiderPos = osm.LatLng(rLat, rLng);
//             osm.LatLng newUserHome = osm.LatLng(uLat, uLng);
//
//             if (!_isInitialized) {
//               setState(() {
//                 _userHome = newUserHome;
//                 _riderPosition = newRiderPos;
//                 _isInitialized = true;
//               });
//               Future.delayed(const Duration(milliseconds: 500), () {
//                 _animatedMapController.animatedFitCamera(
//                   cameraFit: CameraFit.bounds(
//                     bounds: LatLngBounds.fromPoints([newRiderPos, newUserHome]),
//                     padding: EdgeInsets.all(50.w),
//                   ),
//                 );
//               });
//             } else {
//               double newRotation = calculateBearing(
//                 _riderPosition,
//                 newRiderPos,
//               );
//               if (_riderPosition.latitude != newRiderPos.latitude ||
//                   _riderPosition.longitude != newRiderPos.longitude) {
//                 setState(() {
//                   _riderRotation = newRotation;
//                   _riderPosition = newRiderPos;
//                 });
//                 Future.microtask(() {
//                   _animatedMapController.animateTo(
//                     dest: newRiderPos,
//                     rotation: newRotation,
//                     zoom: 15.5,
//                     curve: Curves.easeInOut,
//                     duration: const Duration(milliseconds: 800),
//                   );
//                 });
//               }
//             }
//           }
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Tracing Order",
//           style: TextStyle(fontFamily: "Gilroy", fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: AppColors.primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: !_isInitialized
//           ? const Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 FlutterMap(
//                   mapController: _animatedMapController.mapController,
//                   options: MapOptions(
//                     initialCenter: _storeLocation,
//                     initialZoom: 15.5,
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                       userAgentPackageName: 'com.app.grocery_app',
//                     ),
//                     PolylineLayer(
//                       polylines: [
//                         Polyline(
//                           points: [_riderPosition, _userHome],
//                           strokeWidth: 5.0,
//                           color: AppColors.primaryColor,
//                           borderStrokeWidth: 1.0,
//                           borderColor: Colors.white,
//                           pattern: StrokePattern.dashed(segments: [1, 5]),
//                         ),
//                       ],
//                     ),
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: _storeLocation,
//                           alignment: Alignment.center,
//                           width: 40,
//                           height: 40,
//                           child: const Icon(
//                             Icons.store,
//                             color: Colors.green,
//                             size: 30,
//                           ),
//                         ),
//                         Marker(
//                           point: _userHome,
//                           alignment: Alignment.center,
//                           width: 60,
//                           height: 70,
//                           child: _buildMarker(Icons.home, Colors.blue, "Home"),
//                         ),
//                         Marker(
//                           point: _riderPosition,
//                           alignment: Alignment.center,
//                           width: 60,
//                           height: 70,
//                           child: Transform.rotate(
//                             angle: _riderRotation * (math.pi / 180),
//                             child: Icon(
//                               Icons.delivery_dining,
//                               color: Colors.orange,
//                               size: 40,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   bottom: 30.h,
//                   left: 20.w,
//                   right: 20.w,
//                   child: Container(
//                     padding: EdgeInsets.all(16.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(18.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.1),
//                           blurRadius: 10,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10.w),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.timer,
//                             color: Colors.orange,
//                             size: 24.sp,
//                           ),
//                         ),
//                         SizedBox(width: 15.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 "Order is on the way!",
//                                 style: TextStyle(
//                                   fontFamily: "Gilroy",
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.sp,
//                                 ),
//                               ),
//                               Text(
//                                 "Rider is moving towards your location",
//                                 style: TextStyle(
//                                   fontFamily: "Gilroy",
//                                   color: Colors.grey,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
//
//   Widget _buildMarker(IconData icon, Color color, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
//           ),
//           child: Text(
//             label,
//             style: const TextStyle(
//               fontSize: 10,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         Icon(icon, color: color, size: 35),
//       ],
//     );
//   }
// }
