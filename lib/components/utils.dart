import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/root/app_root.dart';

class Utils {
  Utils._();
  static void navigate({required Widget view}) {
    Get.to(
      () => view,
      duration: Duration(milliseconds: 400),
      transition: Transition.rightToLeft,
    );
  }
 static Widget filterItem({
    required String title,
    required bool value,
    required VoidCallback onTap,
    required ValueChanged<bool?> onChanged,
    Color ?activeColor,
  }) {
    final color = activeColor ?? AppColors.primaryColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 2.0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor:color,side: BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),visualDensity: VisualDensity(vertical: -4,horizontal: -2),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Gilroy",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: value ? color : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
 static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(24.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadiusGeometry.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 20.r,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                Image.asset(
                  "assets/errorScreen_pics/errorBag_pic.png",
                  width: 140.w,
                  height: 140.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 30.h),
                Text(
                  "Oops! Order Failed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Something went terribly wrong.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(height: 40.h),
                AppButtons.socialButton(
                  text: "Please Try Again",
                  onPressed: () {
                    Get.back();
                  },
                  bgColor: AppColors.primaryColor,
                ),
                TextButton(
                  onPressed: () {
                    Get.offAll(()=> AppRoot());
                  },
                  child: Text(
                    "Back to home",
                    style: TextStyle(color: Colors.black,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppColors {
  AppColors._();
  static final  Color  primaryColor = Color(0xff53B175);
  static final Color whiteColor = Color(0xffFFFFFF);
  static final Color lightGrey = Color(0xffC4C4C4);
  static final Color blueColor = Color(0xff5383EC);
  static final Color pinkColor = Color(0xFFFFC0CB);
  static final Color verylightgrey = Color(0xffF2F3F2);
}

class AppButtons {
  static Widget socialButton({
    IconData? icon,
    Size? iconSize,
    required String text,
    required VoidCallback onPressed,
    Color? bgColor,
    double height = 67,
    double width = 353,
  }) {
    final buttonColor = bgColor ?? AppColors.blueColor;
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          iconSize: 28,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.whiteColor),
            SizedBox(width: 8.w),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Gilroy",
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppGradients {
  AppGradients._();
  static final LinearGradient whiteToPink = LinearGradient(
    begin: Alignment.topRight,
    end: const Alignment(0.0, 0.7),
    colors: [
      const Color(0xFFFFD1DC),
      const Color(0xFFFFF0F5),
      Color(0x66FFFFFF),
      Colors.white,
    ],
    stops: const [0.0, 0.4, 0.75, 1.0],
  );
}
