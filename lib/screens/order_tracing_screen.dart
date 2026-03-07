import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/utils.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
 const OrderTrackingScreen({super.key, required this.orderId});

@override
State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

  @override
  void initState() {

    super.initState();
    _simulateRiderMovement();
    _listenToOrderUpdates();


  }

  void _listenToOrderUpdates() {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId)
        .snapshots()
        .listen((snapshot) {

      if (snapshot.exists) {
        String status = snapshot['status'];
        if (status == "Cancelled") {
          Get.back();
          Utils.showErrorDialog(context);
        }
      }
    });
  }
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _storeLocation = LatLng(31.5204, 74.3587);
  static const LatLng _userHome = LatLng(31.5300, 74.3650);
  LatLng _riderPosition = _storeLocation;
  void _simulateRiderMovement() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (mounted) {
        setState(() {
          _riderPosition = LatLng(
            _riderPosition.latitude + 0.0005,
            _riderPosition.longitude + 0.0005,
          );
        });
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newLatLng(_riderPosition),
        );
      }

      if (_riderPosition.latitude >= _userHome.latitude) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tracking Order")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _storeLocation,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          const Marker(
            markerId: MarkerId("store"),
            position: _storeLocation,
            infoWindow: InfoWindow(title: "Store"),
          ),
          Marker(
            markerId: const MarkerId("home"),
            position: _userHome,
            infoWindow: const InfoWindow(title: "Your Home"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
          Marker(
            markerId: const MarkerId("rider"),
            position: _riderPosition,
            infoWindow: const InfoWindow(title: "Rider is here"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          ),
        },
      ),
    );
  }
}