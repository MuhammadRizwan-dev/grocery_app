import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/verification_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  String fullNumber = '';
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
          if (fullNumber.isEmpty) {
            Utils.showSnackBar("Enter phone number");
            return;
          }

          Utils.sendOTP(
            context: context,
            phoneNumber: fullNumber,
            onCodeSent: (verificationId) {
              Get.to(
                    () => VerificationScreen(
                  verificationId: verificationId,
                ),
              );
            },
          );

          Utils.showSnackBar(
            "6 digit code will be sent to your number",
          );
        },

        child: Icon(Icons.arrow_forward_ios_outlined, color: AppColors.whiteColor),
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
                  IntlPhoneField(showCursor: true,
                    initialCountryCode: "BD",
                    showDropdownIcon: true,
                    keyboardType: TextInputType.phone,
                    disableLengthCheck: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                    ),
                    onChanged: (phone) {
                    fullNumber = phone.completeNumber;
                      print("Complete Number is ${phone.completeNumber}");
                    },
                  ),
                  SizedBox(height: 100.h),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}