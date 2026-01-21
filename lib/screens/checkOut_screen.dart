import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/orderAccepted_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        color: AppColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CheckOut",
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Divider(thickness: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery",
                  style: TextStyle(
                    fontSize:17.sp,
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(width: 110.w),
                Text("Select Method", style: TextStyle(fontFamily: "Gilroy")),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
            Divider(thickness: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment",
                  style: TextStyle(
                    fontFamily: "Gilroy",fontSize: 17.sp,
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(width: 180.w),Icon(Icons.payment_sharp,color: Colors.red,),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),Divider(thickness: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Promo Card",
                  style: TextStyle(fontSize: 17.sp,
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(width: 100.w),
                Text("Pick Discount", style: TextStyle(fontFamily: "Gilroy")),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),Divider(thickness: 1,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Cost",
                  style: TextStyle(fontSize: 17.sp,
                    fontFamily: "Gilroy",
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(width: 150.w),
                Text("\$13.97", style: TextStyle(fontFamily: "Gilroy")),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),Divider(thickness: 1,),
            SizedBox(height: 5.h,),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: "Gilroy",
                  color: AppColors.lightGrey,
                  fontSize: 12.sp,
                ),
                children: [
                  TextSpan(text: "By placing an order you agree to \nour "),
                  TextSpan(
                    text: "Terms",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(text: " and "),
                  TextSpan(
                    text: "Conditions",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            AppButtons.socialButton(text: "Place Order", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> OrderacceptedScreen()));
            },bgColor: AppColors.primaryColor)
          ],
        ),
      ),
    );
  }
}
