import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/subProducts_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<Color> colors = [
    Color(0xff53B175B2),
    Color(0xffF8A44CB2),
    Color(0xffF7A593),
    Color(0xffD3B0E0),
    Color(0xffFDE598),
    Color(0xffB7DFF5),
  ];
  final List<Map<String, String>> allItems = [
    {
      "image": "assets/search_screen_pics/pngfuel 6.png",
      "name": "Fresh Fruits & Vegetables",
    },
    {
      "image": "assets/search_screen_pics/Group 6835 (1).png",
      "name": "Cooking Oil & Ghee",
    },
    {"image": "assets/search_screen_pics/pngfuel 9.png", "name": "Meat & Fish"},
    {
      "image": "assets/search_screen_pics/pngfuel 6 (1).png",
      "name": "Bakeri & Snaks",
    },
    {
      "image": "assets/search_screen_pics/dairy&Eggs.png",
      "name": "Dairy & Eggs",
    },
    {
      "image": "assets/search_screen_pics/pngfuel 6 (2).png",
      "name": "Beverages",
    },
  ];

  late List<Map<String, String>> filteredItems;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(allItems);
  }

  void onSearch(String value) {
    setState(() {
      filteredItems = value.isEmpty
          ? List.from(allItems)
          : allItems
                .where(
                  (item) =>
                      item["name"]!.toLowerCase().contains(value.toLowerCase()),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Find Product",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: TextFormField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Search products",
                prefixIcon: Icon(Icons.search, size: 20.sp),
                filled: true,
                fillColor: AppColors.lightGrey.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: filteredItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.w,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SubproductsScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colors[index % colors.length],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            item["image"]!,
                            height: 80.h,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.image, size: 24.sp),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item["name"]!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
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
    );
  }
}
