import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool _isEmailValid = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

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
                    controller: userNameController,
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
                    controller: emailController,
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
                    controller: passwordController,
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
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : AppButtons.socialButton(
                          text: "Sign Up",
                          onPressed: () async {
                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();
                            final username = userNameController.text.trim();
                            if (email.isEmpty ||
                                password.isEmpty ||
                                username.isEmpty) {
                              Utils.showSnackBar("All fields is required");
                              return;
                            }
                            setState(() => _isLoading = true);
                            try {
                              var bannedCheck = await FirebaseFirestore.instance
                                  .collection('users')
                                  .where('email', isEqualTo: email)
                                  .where('status', isEqualTo: "blocked")
                                  .get();
                              if (bannedCheck.docs.isNotEmpty) {
                                Utils.showSnackBar(
                                  "This email address is permanently banned.",
                                  color: Colors.red,
                                );
                                setState(() => _isLoading = false);
                                return;
                              }
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                              await userCredential.user!.updateDisplayName(
                                username,
                              );
                              await userCredential.user!.reload();
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userCredential.user!.uid)
                                  .set({
                                    "uid": userCredential.user!.uid,
                                    "username": username,
                                    "email": email,
                                    "photoUrl": "",
                                    "status": "active",
                                    "createdAt": FieldValue.serverTimestamp(),
                                  });
                              Get.offAll(() => AppRoot());
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "weak-password") {
                                Utils.showSnackBar(
                                  "The Password Provided is too Weak",
                                );
                              } else if (e.code == 'email-already-in-use') {
                                Utils.showSnackBar(
                                  'An account already exists for that email.',
                                );
                              } else {
                                Utils.showSnackBar(
                                  e.message ?? 'Something went wrong',
                                );
                              }
                            } catch (e) {
                              Utils.showSnackBar('Error: $e');
                            } finally {
                              setState(() => _isLoading = false);
                            }
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
                          fontWeight: FontWeight.w600,
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
          ),
        ],
      ),
    );
  }
}
