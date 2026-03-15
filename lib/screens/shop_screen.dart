import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/components/product_card.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/favourite_controller.dart';
import 'package:grocery_app/screens/productDetails_screen.dart';

import '../controllers/user_product_controller.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final UserProductController productController = Get.put(
    UserProductController(),
  );
  final CartController cartController = Get.put(CartController());
  final FavouriteController favouriteController = Get.put(
    FavouriteController(),
  );
  final List<String> banners = [
    "assets/bannerPic.png",
    "assets/bannerPic.png",
    "assets/bannerPic.png",
    "assets/bannerPic.png",
  ];

  final List<Map<String, dynamic>> items = [
    {
      "name": "Organic Banana",
      "detail": "7pc, Priceg",
      "price": "4.99",
      "image": "assets/Banana-Fruit-PNG.png",
    },
    {
      "name": "Red Apple",
      "detail": "1pc, priceg",
      "price": "4.99",
      "image": "assets/APPLE.png",
    },
    {
      "name": "Beef Bone",
      "detail": "1kg, Priceg",
      "price": "4.99",
      "image": "assets/BEEFMEET.png",
    },
    {
      "name": "Broiler Chicken",
      "detail": "1kg, Priceg",
      "price": "4.99",
      "image": "assets/CHICKENMEET.png",
    },
  ];

  final List<Map<String, dynamic>> otherItems = [
    {
      "name": "Bell Pepper Red",
      "detail": "1kg, Priceg",
      "price": "4.99",
      "image": "assets/REDPEPPER.png",
    },
    {
      "name": "Ginger",
      "detail": "1pc,priceg",
      "price": "4.99",
      "image": "assets/GINGER.png",
    },
    {
      "name": "Green Broccoli",
      "detail": "1kg, priceg",
      "price": "4.99",
      "image": "assets/Green-Broccoli-PNG-Clipart.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset("assets/redCarrot.svg", height: 35.h),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 18.sp),
                  SizedBox(width: 4.w),
                  Text(
                    "Dhaka, Banassre",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Search Store",
                      prefixIcon: Icon(Icons.search, size: 20.sp),
                      filled: true,
                      fillColor: AppColors.verylightgrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (context, index, _) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: DecorationImage(
                        image: AssetImage(banners[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 140.h,
                  autoPlay: true,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                ),
              ),

              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Exclusive Offer",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "see all",
                      style: TextStyle(
                        fontSize: 19.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              SizedBox(height: 10.h),
              Obx(() {
                final List<Map<String, dynamic>> combinedItems = [
                  ...items,
                  ...productController.firebaseProducts.map((p) {
                    String fastUrl = p.imageUrl!.replaceFirst(
                      '/upload/',
                      '/upload/w_300,h_300,c_fill,q_auto,f_auto/',
                    );
                    return {
                      "name": p.name,
                      "detail": p.details,
                      "price": p.price.toString(),
                      "image": fastUrl,
                      "isNetwork": true,
                    };
                  }),
                ];

                return SizedBox(
                  height: 214.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    itemCount: combinedItems.length,
                    itemBuilder: (context, index) {
                      final item = combinedItems[index];
                      return ProductCard(
                        item: item,
                        onTap: () {
                          Get.to(() => ProductDetailScreen(product: item));
                        },
                        onAdd: () {
                          cartController.addToCart(item);
                          Utils.showSnackBar("${item["name"]} added to Cart");
                        },
                      );
                    },
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Best Selling",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "see all",
                      style: TextStyle(
                        fontSize: 19.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 214.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemCount: otherItems.length,
                  itemBuilder: (context, index) {
                    final item = otherItems[index];
                    return ProductCard(
                      item: item,
                      onTap: () =>
                          Get.to(() => ProductDetailScreen(product: item)),
                      onAdd: () {
                        cartController.addToCart(item);
                        Utils.showSnackBar("${item["name"]} added to Cart");
                      },
                    );
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
