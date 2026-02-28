import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/root/app_root.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Utils.navigate(view:const WelcomeScreen());
        } else {
          Utils.navigate(view: const AppRoot());
        }

          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset("assets/logo.png", width: 200.w, height: 100.h),
      ),
    );
  }
}
