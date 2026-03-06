import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  child: Image.asset(
                    "assets/orderCompleted.png",
                    width: 250.w,
                    height: 250.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  "Your Order has been\naccepted",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  textAlign: TextAlign.center,
                  "Your items has been placed and is on \n  it’s way to being processed",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightGrey,
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
                      AppButtons.socialButton(
                        text: "Track Order",
                        onPressed: () {
                          Get.to(() =>  OrderTrackingScreen(orderId: widget.orderId,));
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
      ),
    );
  }
}
