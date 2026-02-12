import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/signIn_screen.dart';
import 'package:get/get.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Image.asset("assets/backgroundImage.png", fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/carrotPic.png"),
                  Text(
                    "Welcome",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      fontSize: 48.sp,
                      color: AppColors.whiteColor,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    "to Our Store",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      fontSize: 48.sp,
                      color: AppColors.whiteColor,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    "Get your groceries in as fast as one hour",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.whiteColor,
                      letterSpacing: 0,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  AppButtons.socialButton(
                    bgColor: AppColors.primaryColor,
                    text: "Get Started",
                    onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (_) => SigninScreen()),
                      //   );
                      // },
                      Get.offAll(()=> SigninScreen());
                    } ),
                  // SizedBox(
                  //   height: 67.h,
                  //   width: 353.w,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) {
                  //             return SigninScreen();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.primaryColor,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10.r),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Get Started",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         fontFamily: "Gilroy",
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 18.sp,
                  //         color: AppColors.whiteColor,
                  //         letterSpacing: 0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
