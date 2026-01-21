import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/number_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 0.5.sh,
                width: double.infinity,
                color: AppColors.whiteColor,
                child: Image.asset(
                  "assets/singinpagepic.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Get your groceries",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "with nectar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp,
                    letterSpacing: 0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NumberScreen();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AbsorbPointer(
                    child: IntlPhoneField(
                      initialCountryCode: "BD",showDropdownIcon: false,disableLengthCheck: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
             SizedBox(height: 10.h,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "or connect with social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppButtons.socialButton(
                  text: "Continue with Google",
                  icon: Icons.g_mobiledata,
                  onPressed: () {},
                ),
              ),

              // SizedBox(
              //   height: 67.h,
              //   width: 353.w,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.blueColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.r),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(
              //           Icons.g_mobiledata_outlined,
              //           color: AppColors.whiteColor,
              //         ),
              //         Text(
              //           "Continue with Google",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontFamily: "Gilroy",
              //             color: AppColors.whiteColor,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 18.sp,
              //             letterSpacing: 0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 15.h),
              // SizedBox(
              //   height: 67.h,
              //   width: 353.w,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.blueColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.r),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(Icons.facebook, color: AppColors.whiteColor),
              //         Text(
              //           "Continue with Facebook",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontFamily: "Gilroy",
              //             color: AppColors.whiteColor,
              //             fontWeight: FontWeight.w600,
              //             fontSize: 18.sp,
              //             letterSpacing: 0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppButtons.socialButton(
                  text: "Continue with Facebook",
                  icon: Icons.facebook,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
