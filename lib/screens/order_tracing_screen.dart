// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../components/utils.dart';
//
// class OrderTrackingScreen extends StatefulWidget {
//   final String orderId;
//  const OrderTrackingScreen({super.key, required this.orderId});
//
// @override
// State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
// }
//
// class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
//
//   @override
//   void initState() {
//
//     super.initState();
//     _simulateRiderMovement();
//     _listenToOrderUpdates();
//
//
//   }
//
//   void _listenToOrderUpdates() {
//     FirebaseFirestore.instance
//         .collection('orders')
//         .doc(widget.orderId)
//         .snapshots()
//         .listen((snapshot) {
//
//       if (snapshot.exists) {
//         String status = snapshot['status'];
//         if (status == "Cancelled") {
//           Get.back();
//           Utils.showErrorDialog(context);
//         }
//       }
//     });
//   }
//   final Completer<GoogleMapController> _controller = Completer();
//   static const LatLng _storeLocation = LatLng(31.5204, 74.3587);
//   static const LatLng _userHome = LatLng(31.5300, 74.3650);
//   LatLng _riderPosition = _storeLocation;
//   void _simulateRiderMovement() {
//     Timer.periodic(const Duration(seconds: 2), (timer) async {
//       if (mounted) {
//         setState(() {
//           _riderPosition = LatLng(
//             _riderPosition.latitude + 0.0005,
//             _riderPosition.longitude + 0.0005,
//           );
//         });
//         final GoogleMapController controller = await _controller.future;
//         controller.animateCamera(
//           CameraUpdate.newLatLng(_riderPosition),
//         );
//       }
//
//       if (_riderPosition.latitude >= _userHome.latitude) {
//         timer.cancel();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Tracking Order")),
//       body: GoogleMap(
//         initialCameraPosition: const CameraPosition(
//           target: _storeLocation,
//           zoom: 15,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         markers: {
//           const Marker(
//             markerId: MarkerId("store"),
//             position: _storeLocation,
//             infoWindow: InfoWindow(title: "Store"),
//           ),
//           Marker(
//             markerId: const MarkerId("home"),
//             position: _userHome,
//             infoWindow: const InfoWindow(title: "Your Home"),
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//           ),
//           Marker(
//             markerId: const MarkerId("rider"),
//             position: _riderPosition,
//             infoWindow: const InfoWindow(title: "Rider is here"),
//             icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
//           ),
//         },
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as osm;
import '../components/utils.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final MapController _osmMapController = MapController();
  osm.LatLng _storeLocation = const osm.LatLng(31.5204, 74.3587);
  osm.LatLng _userHome = const osm.LatLng(31.5204, 74.3587);
  osm.LatLng _riderPosition = const osm.LatLng(31.5204, 74.3587);

  @override
  void initState() {
    super.initState();
    _listenToOrderUpdates();
  }

  void _listenToOrderUpdates() {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        String status = data['status'];
        if (status == "Cancelled") {
          Get.back();
          Utils.showErrorDialog(context);
        }
        if (data.containsKey('userLat') && data.containsKey('riderLatitude')) {
          setState(() {
            _userHome = osm.LatLng(data['userLat'], data['userLng']);
            _riderPosition =
                osm.LatLng(data['riderLatitude'], data['riderLongitude']);
          });
          _osmMapController.move(_riderPosition, 15);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tracing Order",
          style: TextStyle(fontFamily: "Gilroy", fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // 1. Map Layer
          FlutterMap(
            mapController: _osmMapController,
            options: MapOptions(initialCenter: _storeLocation, initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.app.grocery_app',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [_riderPosition, _userHome],
                    strokeWidth: 4.0,
                    color: AppColors.primaryColor.withValues(alpha: 0.7),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _storeLocation,alignment: Alignment.topCenter,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.store, color: Colors.green, size: 30),
                  ),
                  Marker(
                    point: _userHome,alignment: Alignment.topCenter,
                    width: 60,
                    height: 70,
                    child: _buildProfessionalMarker(Icons.home, Colors.blue, "Home"),
                  ),
                  Marker(
                    point: _riderPosition,
                    alignment: Alignment.topCenter,
                    width: 60,
                    height: 70,
                    child: _buildProfessionalMarker(Icons.delivery_dining, Colors.orange, "Rider"),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.timer, color: Colors.orange, size: 24.sp),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Order is on the way!",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          "Rider is moving towards your location",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalMarker(IconData icon, Color color, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Icon(icon, color: color, size: 35),
      ],
    );
  }
}