import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/apptextfield.dart';
import 'package:grocery_app/screens/logIn_screen.dart';

import '../components/utils.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.whiteToPink),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Image.asset(
                    "assets/location.png",
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 15.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Select Your Location",
                      style: TextStyle(
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                        fontSize: 26.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    Text(
                      "Switch on your location to stay in tune with\nwhat's happening in your area",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Gilroy",fontWeight: FontWeight.w600,
                        color: AppColors.lightGrey,
                        fontSize: 15.sp,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Text(
                  "Your Zone",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                Apptextfield(
                  hint: "Select your city/zone",
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
                  ),
                  fontSize: 15.sp,
                ),

                SizedBox(height: 15.h),
                Text(
                  "Your Area",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                Apptextfield(
                  hint: "Types your area",
                  fontSize: 15.sp,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_down_rounded, size: 15.sp),
                  ),
                ),

                SizedBox(height: 30.h),
                AppButtons.socialButton(
                  text: "Submit",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));
                  },
                  bgColor: AppColors.primaryColor,
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
