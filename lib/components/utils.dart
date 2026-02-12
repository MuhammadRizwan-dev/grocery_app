import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/root/app_root.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';

class Utils {
  Utils._();
  // static Future<UserCredential?> signInWithFacebook() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.login(
  //       permissions: ['email', 'public_profile'],
  //     );
  //     if (result.status != LoginStatus.success) return null;
  //     final credential = FacebookAuthProvider.credential(
  //       result.accessToken!.tokenString,
  //     );
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     Utils.showSnackBar("LogIn Failed :$e");
  //     print("$e");
  //     return null;
  //   }
  // }
  // static Future<void> signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   if (await googleSignIn.isSignedIn()) {
  //     await googleSignIn.disconnect();
  //     Get.offAll(() => LoginScreen());
  //     showSnackBar("SignOut SuccessFully",color: Colors.green);
  //   }
  //
  //   await GoogleSignIn().signOut();
  //}
  static void sendOTP({
    required BuildContext context,
    required String phoneNumber,
    required Function(String VerificationId) onCodeSent,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException e) {
        showSnackBar(e.message ?? "OTP Failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Google SignIn Error: $e");
      showSnackBar("Google Sign-In failed");
      return null;
    }
  }

  static void showSnackBar(String message, {Color? color}) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  static void navigate({required Widget view}) {
    Get.offAll(
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
    Color? activeColor,
  }) {
    final color = activeColor ?? AppColors.primaryColor;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: color,
              side: BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              visualDensity: VisualDensity(vertical: -4, horizontal: -2),
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
            borderRadius: BorderRadius.circular(24.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 20.r,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                          Get.offAll(() => const AppRoot());
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          "Back to home",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Gilroy",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}

class AppColors {
  AppColors._();
  static final Color primaryColor = Color(0xff53B175);
  static final Color whiteColor = Color(0xffFFFFFF);
  static final Color lightGrey = Color(0xffC4C4C4);
  static final Color blueColor = Color(0xff5383EC);
  static final Color pinkColor = Color(0xFFFFC0CB);
  static final Color verylightgrey = Color(0xffF2F3F2);
}

class AppButtons {
  static Widget socialButton({
    Widget? icon,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SizedBox(
                height: height.h * 0.35,
                width: height.h * 0.35,
                child: icon,
              ),
              SizedBox(width: 15.w),
            ],
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
