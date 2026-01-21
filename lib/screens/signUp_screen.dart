import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/root/app_root.dart';

import '../components/apptextfield.dart';
import '../components/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isPasswordHidden = true;
  TextEditingController emailcontroller = TextEditingController();
  bool _isEmailValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(gradient: AppGradients.whiteToPink),
            child: Column(
              children: [
                SizedBox(height: 70.h),
                SvgPicture.asset("assets/redCarrot.svg", height: 50.h),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Enter your credentials to continue",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Apptextfield(
                    label: "Username",
                    textInputAction: TextInputAction.next,
                    labelStyle: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Apptextfield(
                    label: "Email",
                    controller: emailcontroller,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid =
                            value.endsWith("@gmail.com") ||
                            value.contains("@gmail");
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    labelStyle: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontSize: 14.sp,
                    ),
                    suffixIcon: _isEmailValid
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.check,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(height: 20.h),

                  Apptextfield(
                    label: "Password",
                    textInputAction: TextInputAction.done,
                    isPassword: _isPasswordHidden,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Gilroy",
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(text: "By continuing you agree to our "),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(color: AppColors.primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: AppColors.primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  AppButtons.socialButton(
                    text: "Sign Up",
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (_) => AppRoot()));
                    },
                    bgColor: AppColors.primaryColor,
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            color: AppColors.primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
