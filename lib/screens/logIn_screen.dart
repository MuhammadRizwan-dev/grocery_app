import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/root/app_root.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                    child: SvgPicture.asset(
                      "assets/redCarrot.svg",
                      height: 50.h,
                    ),
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
                    "LogIn",
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
                    controller: emailController,
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
                    controller: passwordController,
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
                    onPressed: () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        Utils.showSnackBar("Email & Password is required");
                        return;
                      }
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        DocumentSnapshot userDoc =await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).get();
                        if (userDoc.exists) {
                          final data = userDoc.data() as Map<String, dynamic>?;
                          String status = data?['status'] ?? "active";

                          if (status == "blocked") {
                            await FirebaseAuth.instance.signOut();
                            Utils.showSnackBar("Your account is permanently banned by Admin.", color: Colors.red);
                            return;
                          }

                          if (status == "stopped") {
                            await FirebaseAuth.instance.signOut();
                            Utils.showSnackBar("Your account is temporarily suspended.", color: Colors.orange);
                            return;
                          }
                        }
                        Get.offAll(() => AppRoot());
                      //  await userCredential.user!.reload();
                      //  await FirebaseAuth.instance.signInWithEmailAndPassword(
                        //  email: email,
                          //password: password,
                       // );
                      //  Get.offAll(()=> AppRoot());
                      }on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          case 'user-not-found':
                            Utils.showSnackBar("No account found with this email");
                            break;
                          case 'wrong-password':
                            Utils.showSnackBar("Incorrect password");
                            break;
                          case 'invalid-email':
                            Utils.showSnackBar("Invalid email address");
                            break;
                          default:
                            Utils.showSnackBar("Login failed, try again");
                        }
                      }
                    },
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
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                         Get.to(()=> SignupScreen());
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (_) => SignupScreen()),
                          // );
                        },
                        child: Text(
                          " SingUp",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
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
