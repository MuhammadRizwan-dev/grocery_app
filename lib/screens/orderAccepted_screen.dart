import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/order_controller.dart';

import '../root/app_root.dart';
import 'order_tracing_screen.dart';

class OrderAcceptedScreen extends StatefulWidget {
  final String orderId;
  const OrderAcceptedScreen({super.key, required this.orderId});

  @override
  State<OrderAcceptedScreen> createState() => _OrderAcceptedScreenState();
}

class _OrderAcceptedScreenState extends State<OrderAcceptedScreen> {
  final CartController cartController = Get.find();
  final OrderController orderController = Get.find();
  @override
  void initState() {
    super.initState();
    orderController.trackCurrentOrder(widget.orderId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        String status = orderController.currentOrderStatus.value;
        return SingleChildScrollView(
          child: Container(
            height: 1.0.sh,
            decoration: BoxDecoration(gradient: AppGradients.whiteToPink),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 50,
                    ),
                    child: status == "Pending"
                        ? SizedBox(
                            height: 250.h,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        : Image.asset(
                            "assets/orderCompleted.png",
                            width: 250.w,
                            height: 250.h,
                            fit: BoxFit.contain,
                          ),
                  ),
                  Text(
                    status == "Pending"
                        ? "Waiting for Shop\nto Confirm..."
                        : "Your Order has been\naccepted",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    status == "Pending"
                        ? "Please wait while the shop checks your order"
                        : "Your items have been placed and are on \n it’s way to being processed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey,
                    ),
                  ),
                  if (status == "Pending")
                    Padding(
                      padding: EdgeInsets.only(top: 15.h),
                      child: TextButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Cancel Order?",
                            titleStyle: TextStyle(fontFamily: "Gilroy", fontWeight: FontWeight.bold),
                            middleText: "Are you sure you want to cancel this order?",
                            middleTextStyle: TextStyle(fontFamily: "Gilroy"),
                            textConfirm: "Yes, Cancel",
                            textCancel: "No",
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.red,
                            onConfirm: () {
                              Get.back();
                              orderController.cancelOrder(widget.orderId);
                            },
                          );
                        },
                        child: Text(
                          "Cancel Order",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (status == "Accepted")
                        AppButtons.socialButton(
                          text: "Track Order",
                          onPressed: () {
                            Get.to(
                              () =>
                                  OrderTrackingScreen(orderId: widget.orderId),
                            );
                          },
                          bgColor: AppColors.primaryColor,
                        ),
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () {
                            Get.offAll(() => AppRoot());
                          },
                          child: Container(
                            height: 60.h,
                            child: Text(
                              "Back to home",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Center(
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Get.offAll(() => AppRoot());
                  //     },
                  //     child: Text(
                  //       textAlign: TextAlign.center,
                  //       "Back to home",
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //         fontFamily: "Gilroy",
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 20.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // AppButtons.socialButton(
                  //   text: "Back To Home",
                  //   onPressed: () {},
                  //   bgColor: Colors.transparent,
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
