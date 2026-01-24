import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/shop_screen.dart';

import '../root/app_root.dart';

class OrderacceptedScreen extends StatelessWidget {
  const OrderacceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.whiteToPink),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/orderCompleted.png",
                width: 250.w,
                height: 250.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 40.h),
              Text(
                "Your Order has been \n accepted",
                style: TextStyle(
                  fontFamily: "Gilroy",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Your items has been placed and is on \n  it’s way to being processed",
                style: TextStyle(
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightGrey,
                ),
              ),
              SizedBox(height: 30.h),
              AppButtons.socialButton(
                text: "Track Order",
                onPressed: () => Utils.showErrorDialog(context),
                bgColor: AppColors.primaryColor,
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(()=> AppRoot());
                },
                child: Text(
                  "Back to home",
                  style: TextStyle(color : Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ),
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
  }
}
