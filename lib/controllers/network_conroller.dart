import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  bool _isDialogShowing = false;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      if (!_isDialogShowing) {
        _isDialogShowing = true;
        _showNoInternetDialog();
      }
    } else {
      if (_isDialogShowing) {
        _isDialogShowing = false;
        if (Get.isDialogOpen == true) Get.back();
      }
    }
  }

  void _showNoInternetDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.red),
            SizedBox(width: 10),
            Text("No Internet"),
          ],
        ),
        content: const Text(
          "Internet is off. Please  check Connection and try again!",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              var connectivityResult = await _connectivity.checkConnectivity();
              if (connectivityResult != ConnectivityResult.none) {
                _isDialogShowing = false;
                Get.back();
                Get.snackbar(
                  "Connected",
                  "Internet is back!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              } else {
                Get.rawSnackbar(
                  message: "Please Try Again!",
                  duration: const Duration(seconds: 2),
                );
              }
            },
            child: const Text("Retry", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}