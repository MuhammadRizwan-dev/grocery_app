import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/screens/signUp_screen.dart';

import '../components/apptextfield.dart';
import '../components/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(gradient: AppGradients.whiteToPink),
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  Center(

                    child: SvgPicture.asset("assets/redCarrot.svg", height: 50.h),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    "Loging",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Enter your emails and password",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  Apptextfield(
                    label: "Email",
                    labelStyle: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Apptextfield(
                    label: "Password",
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
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  AppButtons.socialButton(
                    text: "Log In",
                    onPressed: () {},
                    bgColor: AppColors.primaryColor,
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignupScreen()),
                          );
                        },
                        child: Text(
                          " Singup",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
