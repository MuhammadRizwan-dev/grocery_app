import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
        //  home: VerificationScreen(),
        //  home: LoginScreen(),
        //  home: ShopScreen(),
        // home: SearchScreen(),
        //  home: ProductDetailScreen(),
        //   home: SubproductsScreen(),
        //    home: WelcomeScreen(),);
      },
    );
  }
}
