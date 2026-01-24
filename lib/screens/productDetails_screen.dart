import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/data/favourite_data.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String , dynamic> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/export.svg"),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280.h,
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Image.asset('assets/APPLE.png', fit: BoxFit.contain),
            ),

            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Natural Red Apple",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isFavourite = !_isFavourite;
                          });
                          toggleFavorite(widget.product);
                        },
                        icon: _isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: AppColors.primaryColor,
                              )
                            : Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "1kg, Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      color: AppColors.lightGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),

                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove,size: 30.sp,),
                            color: AppColors.lightGrey,
                            onPressed: () {
                              if (quantity > 1) setState(() => quantity--);
                            },
                          ),
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightGrey),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "$quantity",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add,size: 30.sp,),
                            color: AppColors.primaryColor,
                            onPressed: () => setState(() => quantity++),
                          ),
                        ],
                      ),
                      Text(
                        "\$4.99",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(height: 10.h,thickness: 1,),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Detail",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, size: 30.sp),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Apples are nutritious. Apples may be good for weight loss. "
                    "Apples may be good for your heart. As part of a healthy and varied diet.",
                    style: TextStyle(
                      fontSize: 15.sp,fontWeight: FontWeight.w600,
                      color: AppColors.lightGrey,
                      height: 1.4,
                    ),
                  ),

                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nutritions", style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),),
                      Row(
                        children: [
                          Text("100g", style: TextStyle(color: Colors.grey)),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Divider(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Review", style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),),
                      Row(
                        children: [
                          Text("★★★★★",  style: TextStyle(
                            fontSize: 15.sp,color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  AppButtons.socialButton(text: "Add to Basket", onPressed: (){},bgColor: AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
