import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/selectFilter_screen.dart';
import '../components/utils.dart';

class SubproductsScreen extends StatefulWidget {
  const SubproductsScreen({super.key});

  @override
  State<SubproductsScreen> createState() => _SubproductsScreenState();
}

class _SubproductsScreenState extends State<SubproductsScreen> {
  final List<Map<String, dynamic>> subItems = [
    {
      "name": "Diet Coke",
      "details": "355ml, Price",
      "price": "1.99",
      "image": "assets/Diet-Coke-PNG-HD.png",
    },
    {
      "name": "Sprite Can",
      "details": "325ml, Price",
      "price": "1.50",
      "image": "assets/Sprite-Can-PNG.png",
    },
    {
      "name": "Apple & Grape Juice",
      "details": "2L, Price",
      "price": "15.99",
      "image": "assets/tree-top-juice-apple-grape-64oz 1.png",
    },
    {
      "name": "Orange Juice",
      "details": "2L, Price",
      "price": "15.99",
      "image": "assets/tree-top-juice-apple-grape-64oz 1 (1).png",
    },
    {
      "name": "Coca Cola Can",
      "details": "325ml, Price",
      "price": "4.99",
      "image": "assets/Coke-Can-PNG-HD.png",
    },
    {
      "name": "Pepsi Can",
      "details": "330ml, Price",
      "price": "4.99",
      "image": "assets/Pepsi-Can-PNG-Pic.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Beverages",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/settingIcon.svg",
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: subItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final item = subItems[index];
          return Container(
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
                  child: Image.asset(
                    item["image"],
                    height: 90.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  item["name"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item["details"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF7C7C7C),
                  ),
                ),
                const Spacer(),
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
                            content: Text("${item["name"]} added to Cart"),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
