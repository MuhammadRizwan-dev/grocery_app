import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/data/cart_data.dart';
import 'package:grocery_app/screens/checkOut_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget qty(IconData icon, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        width: 36.w,
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Color(0xFFE2E2E2)),
        ),
        child: Icon(icon, size: 18.sp, color: iconColor),
      ),
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item["price"]);
    }
    return total;
  }
 void openCheckOutSheet(BuildContext context){
    showModalBottomSheet(context: context,
        isScrollControlled: true,backgroundColor: Colors.transparent,
        builder: (_)=> CheckoutScreen());
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor,
        title: Text(
          "My Cart",
          style: TextStyle(fontFamily: "Gilroy",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body:
          // cartItems.isEmpty
          //     ? Center(
          //         child: Text(
          //           "Your cart is empty",
          //           style: TextStyle(fontSize: 18).copyWith(fontSize: 18.sp),
          //         ),
          //       )
          //     :
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(12.w),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                       // borderRadius: BorderRadius.circular(10.r),
                        border: Border(
                          top: BorderSide(color: Color(0xFFE2E2E2)),
                          bottom: BorderSide(color: Color(0xFFE2E2E2)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            item["image"],
                            height: 55.h,
                            width: 55.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item["detail"],
                                  style: TextStyle(
                                    color: Color(0xFF7C7C7C),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    qty(Icons.remove, Colors.black, () {}),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0.w,
                                      ),
                                      child: Text(
                                        "1",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                    qty(Icons.add, Color(0xFF53B175), () {}),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    cartItems.removeAt(index);
                                  });
                                },
                                child: Icon(Icons.close, color: Colors.grey.shade400),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                "\$${item["price"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              AppButtons.socialButton(text: "Go To CheckOut", onPressed: ()=> openCheckOutSheet(context),bgColor: AppColors.primaryColor)
            ],
          ),
    );
  }
}
