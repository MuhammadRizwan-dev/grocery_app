import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/verification_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerificationScreen(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "4 digit code will be sent to Your Number within 10 sec Please Wait!",
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(milliseconds: 2000),
            ),
          );
        },
        child: Icon(Icons.arrow_forward, color: AppColors.whiteColor),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.45.sh,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppGradients.whiteToPink,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              // height: 1.sh  ← REMOVE THIS LINE (this was causing conflict)
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    "Enter Your Number",
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      fontSize: 26.sp,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    "Mobile Number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  IntlPhoneField(
                    initialCountryCode: "BD",
                    showDropdownIcon: false,
                    keyboardType: TextInputType.phone,
                    disableLengthCheck: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                    ),
                    onChanged: (phone) {
                      print("Complete Number is ${phone.completeNumber}");
                    },
                  ),
                  SizedBox(height: 100.h), // already there, good for spacing
                  SizedBox(height: 80.h),   // ← extra bottom space so FAB doesn't cover content
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}