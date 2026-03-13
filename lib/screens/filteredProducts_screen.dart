import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screens/selectFilter_screen.dart';
import 'package:grocery_app/screens/subProducts_screen.dart';

import '../components/product_card.dart';
import '../components/utils.dart';
import '../controllers/cart_controller.dart';

class FilteredproductsScreen extends StatefulWidget {
  final String appliedText;

  const FilteredproductsScreen({super.key, required this.appliedText});

  @override
  State<FilteredproductsScreen> createState() => _FilteredproductsScreenState();
}

class _FilteredproductsScreenState extends State<FilteredproductsScreen> {
  final CartController cartController = Get.find();
  final List<Map<String, String>> allItems = [
    {
      "name": "Egg Chicken Red",
      "details": "4Pcs, Price",
      "price": "1.99",
      "image": "assets/filtered_screen_pics/chicken_eggs_red.png",
    },
    {
      "name": "Egg Chicken White",
      "details": "180g, Price",
      "price": "1.50",
      "image": "assets/filtered_screen_pics/chicken_egg_white.png",
    },
    {
      "name": "Egg Pasta",
      "details": "30gm, Price",
      "price": "15.99",
      "image": "assets/filtered_screen_pics/egg_nodles_green.png",
    },
    {
      "name": "Egg Nodles",
      "details": "2l, Price",
      "price": "15.99",
      "image": "assets/filtered_screen_pics/egg-noodle.png",
    },
    {
      "name": "Mayonnaise Eggless",
      "details": "1l, Price",
      "price": "12.99",
      "image": "assets/filtered_screen_pics/Mayonnaise_Eggless.png",
    },
    {
      "name": "Egg Noodles",
      "details": "30gm, Price",
      "price": "10.99",
      "image": "assets/filtered_screen_pics/egg_noodles_long.png",
    },
  ];
  late List<Map<String, String>> filteredItems;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.text = widget.appliedText;

    filteredItems = allItems.where((item) {
      final name = item["name"]!.toLowerCase();
      final applied = widget.appliedText.toLowerCase().trim();

      if (applied.isEmpty) return true;
      if (applied == "eggs") return name.contains("egg");
      if (applied == "noodles & pasta") return name.contains("pasta") || name.contains("noodle");
      if (applied == "fast food") return name.contains("burger") || name.contains("pizza");
      return name.contains(applied);
    }).toList();
  }

  void onSearch(String value) {
    final val = value.toLowerCase().trim();

    setState(() {
      filteredItems = allItems.where((item) {
        final name = item["name"]!.toLowerCase();

        if (val.isEmpty) return true;

        if (val == "eggs") return name.contains("egg");
        if (val == "noodles & pasta") return name.contains("pasta") || name.contains("noodle");
        if (val == "fast food") return name.contains("burger") || name.contains("pizza");

        return name.contains(val);
      }).toList();
    });
  }


  void clearSearch() {
    searchController.clear();
    onSearch("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 52.h,
                    child: TextFormField(
                      controller: searchController,
                      onChanged: onSearch,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, size: 20.sp),
                        suffixIcon: searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: clearSearch,
                                child: Icon(Icons.close, size: 20.sp),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectfilterScreen();
                        },
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    "assets/settingIcon.svg",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredItems.isEmpty
                ? Center(child: Text("No items found"))
                : GridView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: filteredItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.w,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  item: filteredItems[index],
                  onTap: () {
                    Get.to(() => SubproductsScreen(item: filteredItems[index]));
                  },
                  onAdd: () {
                    cartController.addToCart(filteredItems[index]);
                    Utils.showSnackBar("${filteredItems[index]['name']} added to cart!");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
