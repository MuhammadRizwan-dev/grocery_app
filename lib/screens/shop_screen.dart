import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/productDetails_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
              // Logo
              Center(
                child: SvgPicture.asset("assets/redCarrot.svg", height: 35.h),
              ),

              SizedBox(height: 12.h),

              // Location row
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

              // Search bar
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

              // Banner carousel
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
              SizedBox(
                height: 214.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: item),
                          ),
                        );
                      },
                      child: Container(
                        width: 165.w,
                        margin: EdgeInsets.only(right: 16.w),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(color: AppColors.verylightgrey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(item["image"], height: 78.h),
                            ),
                            SizedBox(height: 14.h),
                            Flexible(
                              child: Text(
                                item["name"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Flexible(
                              child: Text(
                                item["detail"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF7C7C7C),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${item["price"]}",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${item["name"]} added to Cart",
                                        ),
                                        backgroundColor: Colors.grey,
                                        duration: Duration(milliseconds: 1000),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
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
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  itemCount: otherItems.length,
                  itemBuilder: (context, index) {
                    final item = otherItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: item),
                          ),
                        );
                      },
                      child: Container(
                        width: 165.w,
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(item["image"], height: 80.h),
                            ),
                            SizedBox(height: 10.h),
                            Flexible(
                              child: Text(
                                item["name"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                item["detail"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${item["price"]}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${item["name"]} added to Cart",
                                        ),
                                        duration: Duration(milliseconds: 1000),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
