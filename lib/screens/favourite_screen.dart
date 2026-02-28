import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/favourite_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteController favouriteController = Get.put(
    FavouriteController(),
  );
  final CartController cartController = Get.find();
  // final List<Map<String, dynamic>> staticFavList = [
  //   {
  //     "name": "Sprite Can",
  //     "detail": "325ml, Price",
  //     "price": "1.50",
  //     "image": "assets/Sprite-Can-PNG.png",
  //   },
  //   {
  //     "name": "Diet Coke",
  //     "detail": "325ml, Price",
  //     "price": "1.99",
  //     "image": "assets/Diet-Coke-PNG-HD.png",
  //   },
  //   {
  //     "name": "Apple & Grape Juice",
  //     "detail": "2L, Price",
  //     "price": "15.50",
  //     "image": "assets/Apple-Juice-PNG-Photos.png",
  //   },
  //   {
  //     "name": "Coca Cola Can",
  //     "detail": "325ml, Price",
  //     "price": "4.99",
  //     "image": "assets/Coke-Can-PNG-HD.png",
  //   },
  //   {
  //     "name": "Pepsi Can",
  //     "detail": "330ml, Price",
  //     "price": "4.99",
  //     "image": "assets/Pepsi-Can-PNG-Pic.png",
  //   },
  // ];
  //
  // List<Map<String, dynamic>> dynamicFavList = [];
  //
  // List<Map<String, dynamic>> get favList => [
  //   ...staticFavList,
  //   ...favouriteItems,
  // ];
  // @override
  // void initState() {
  //   super.initState();
  //   dynamicFavList = favouriteItems;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Text(
              "Favourite",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                // final combinedList = [
                //   ...staticFavList,
                favouriteController.favouriteItems;
                // ];
                //   if (combinedList.isEmpty) {
                if (favouriteController.favouriteItems.isEmpty) {
                  return Center(child: Text("No Favourite Yet"));
                }
                return ListView.builder(
                  //   itemCount: combinedList.length,
                  itemCount: favouriteController.favouriteItems.length,
                  itemBuilder: (context, index) {
                    //   final item = combinedList[index];
                    final item = favouriteController.favouriteItems[index];
                    return Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFE2E2E2)),
                          bottom: BorderSide(color: Color(0xFFE2E2E2)),
                        ),
                      ),
                      child: Row(
                        children: [
                          item["isNetwork"] == true
                              ? Image.network(
                                  item["image"],
                                  height: 55.h,
                                  width: 55.w,
                                  fit: BoxFit.contain,
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
                                    fontFamily: "Gilroy",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item["detail"],
                                  style: TextStyle(
                                    fontFamily: "Gilroy",
                                    fontSize: 13.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${item["price"]}",
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(width: 10.w),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chevron_right, size: 22.sp),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20.h),
            AppButtons.socialButton(
              text: "Add All To Cart",
              bgColor: AppColors.primaryColor,
              onPressed: () {
                // final allItems = [
                //  ...staticFavList,
                // ...favouriteController.favouriteItems,
                //  ];
                // if(allItems.isEmpty){
                if (favouriteController.favouriteItems.isEmpty) {
                  Utils.showSnackBar("Your Favourite List is empty");
                } else {
                  // for(var item in allItems){
                  for (var item in favouriteController.favouriteItems) {
                    Map<String, dynamic> cartProducts =
                        Map<String, dynamic>.from(item);
                    cartProducts["qty"] = 1;
                    cartController.addToCart(cartProducts);
                  }
                  Utils.showSnackBar("All Items added to Your basket!");
                }
              },
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 56.h,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF53B175),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(19.r),
            //       ),
            //     ),
            //     onPressed: () {},
            //     child: Text(
            //       "Add All To Cart",
            //       style: GoogleFonts.poppins(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
