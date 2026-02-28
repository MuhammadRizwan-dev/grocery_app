import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey =
      "pk_test_51T4toxJ9jDKffTGguBhZgc0jAIEQZYfL8BkWLYfDWjCQC3MPSa7bcVFmCvef6Ucj1KtTiGpqzejwt70n08LY8G0y00Wq2cRQRw";
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          initialBinding: BindingsBuilder(() {
            Get.put(CartController());
          }),
          theme: ThemeData(fontFamily: "Gilroy"),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
