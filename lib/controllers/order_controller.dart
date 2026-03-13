import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:geolocator/geolocator.dart';

class OrderController extends GetxController {
  StreamSubscription? _ordersListSub;
  StreamSubscription? _notificationsSub;
  StreamSubscription? _trackingSub;
  final AudioPlayer _audioPlayer = AudioPlayer();
  var myOrders = <QueryDocumentSnapshot>[].obs;
  var isLoading = true.obs;
  var currentOrderStatus = "Pending".obs;
  @override
  void onInit() {
    super.onInit();
    fetchOrders();
    listenToStatusNotifications();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    _ordersListSub?.cancel();
    _notificationsSub?.cancel();
    _trackingSub?.cancel();
    super.onClose();
  }

  void trackCurrentOrder(String orderId) {
    currentOrderStatus.value = "Pending";

    _trackingSub = FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            String status = snapshot['status'] ?? "Pending";
            currentOrderStatus.value = status;
            if (status == "Cancelled") {
              if (Get.isOverlaysOpen) Get.back();
              Get.back();
              Utils.showErrorDialog(Get.context!);
            }
          }
        });
  }

  void fetchOrders() {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (uid.isNotEmpty) {
      _ordersListSub = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: uid)
          .snapshots()
          .listen(
            (snapshot) {
              myOrders.value = snapshot.docs;
              isLoading.value = false;
            },
            onError: (e) {
              print("Error fetching orders: $e");
              isLoading.value = false;
            },
          );
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {'status': 'Cancelled', 'cancelledBy': 'User'},
      );

      Get.snackbar(
        "Order Cancelled",
        "Your order has been cancelled successfully",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Could not cancel order: $e");
    }
  }

  void listenToStatusNotifications() {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (uid.isNotEmpty) {
      _notificationsSub = FirebaseFirestore.instance
          .collection('user_notifications')
          .where('userId', isEqualTo: uid)
          .where('isSeen', isEqualTo: false)
          // .where('timestamp', isGreaterThan: Timestamp.now())
          .snapshots()
          .listen((snapshot) {
            for (var change in snapshot.docChanges) {
              if (change.type == DocumentChangeType.added) {
                var data = change.doc.data() as Map<String, dynamic>;
                String status = data['status'] ?? "";
                Vibration.hasVibrator().then((hasVibrator) {
                  if (hasVibrator == true) {
                    if (status == "Cancelled") {
                      _audioPlayer.play(AssetSource("sounds/error.mp3"));
                      Vibration.vibrate(pattern: [0, 200, 100, 200, 100, 600]);
                    } else {
                      _audioPlayer.play(AssetSource("sounds/alerts.mp3"));
                      Vibration.vibrate(duration: 500);
                    }
                  }
                });

                Get.snackbar(
                  data['title'] ?? "Order Update!",
                  data['message'] ?? "Order Status is Updated",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: status == "Cancelled"
                      ? Colors.red.shade700
                      : AppColors.primaryColor,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 5),
                  icon: Icon(
                    status == "Cancelled"
                        ? Icons.cancel_outlined
                        : Icons.notifications_active,
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.all(10),
                );
                change.doc.reference.update({'isSeen': true});
              }
            }
          });
    }
  }

  Future<String?> placeOrder({
    required List items,
    required double total,
    required String address,
    required String paymentMethod,
    required String paymentStatus,
  }) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
      String name =
          FirebaseAuth.instance.currentUser?.displayName ?? "Customer";
      String displayOrderId = "ORD-${DateTime.now().millisecondsSinceEpoch}";
      DocumentReference orderDoc = await FirebaseFirestore.instance
          .collection('orders')
          .add({
            'orderNumber': displayOrderId,
            'userId': uid,
            'userName': name,
            'items': items,
            'totalPrice': total,
            'address': address,
            'status': 'Pending',
            'paymentMethod': paymentMethod,
            'paymentStatus': paymentStatus,
            'userLatitude': position.latitude,
            'userLongitude': position.longitude,
            'riderLatitude': position.latitude,
            'riderLongitude': position.longitude,
            'createdAt': FieldValue.serverTimestamp(),
          });
      await FirebaseFirestore.instance.collection('admin_notifications').add({
        'orderId': displayOrderId,
        'message': 'New Order($paymentMethod) from : $name arrived',
        'amount': total,
        'paymentStatus': paymentStatus,
        'isRead': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint("Order Placed Successfully with $paymentMethod!");
      return orderDoc.id;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Order failed: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    }
  }
}
