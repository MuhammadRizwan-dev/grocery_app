import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'controllers/network_conroller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Warning: .env file not found");
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "";
  await Stripe.instance.applySettings();
  Get.put(NetworkController(), permanent: true);
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
          theme: ThemeData(fontFamily: "Gilroy",),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
