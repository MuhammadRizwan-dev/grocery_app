import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/screens/checkOut_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find();
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

  void openCheckOutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "My Cart",
          style: TextStyle(
            fontFamily: "Gilroy",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => cartController.cartItems.isEmpty
            ? Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 18).copyWith(fontSize: 18.sp),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(12.w),
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartController.cartItems[index];
                        return Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Color(0xFFE2E2E2)),
                              bottom: BorderSide(color: Color(0xFFE2E2E2)),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              item["isNetwork"] == true
                                  ? Image.network(
                                      item["image"],
                                      height: 55.h,
                                      width: 55.w,
                                      fit: BoxFit.contain,
                                      errorBuilder: (c, e, s) =>
                                          Icon(Icons.broken_image),
                                    )
                                  : Image.asset(
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
                                        qty(Icons.remove, Colors.black, () {
                                          cartController.decreaseQuantity(
                                            index,
                                          );
                                        }),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w,
                                          ),
                                          child: Text(
                                            "${item["qty"]}",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ),
                                        qty(Icons.add, Color(0xFF53B175), () {
                                          cartController.addQuantity(index);
                                        }),
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
                                      cartController.removeFromCart(index);
                                      Utils.showSnackBar(
                                        "${item["name"]} removed from cart",
                                      );
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    " \$${(double.parse(item["price"].toString().replaceAll('\$', '')) * item["qty"]).toStringAsFixed(2)}",
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
                  AppButtons.socialButton(
                    text:
                        "Go To CheckOut \$${cartController.totalPrice.toStringAsFixed(2)}",
                    onPressed: () => openCheckOutSheet(context),
                    bgColor: AppColors.primaryColor,
                  ),
                ],
              ),
      ),
    );
  }
}
