import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/filteredProducts_screen.dart';
import 'package:grocery_app/screens/subProducts_screen.dart';

class SelectfilterScreen extends StatefulWidget {
  const SelectfilterScreen({super.key});

  @override
  State<SelectfilterScreen> createState() => _SelectfilterScreenState();
}

class _SelectfilterScreenState extends State<SelectfilterScreen> {
  String? selectedCategory;
  String? selectedBrand;
  List<String> categories = [
    "Eggs",
    "Noodles & Pasta",
    "Chips & Crips",
    "Fast Food",
  ];

  List<String> brands = [
    "Individual Collection",
    "Cocola",
    "Ifad",
    "Kazi Farmas",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        toolbarHeight: 90.h,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SubproductsScreen()),
            );
          },
        ),
        title: Text(
          "Filters",
          style: TextStyle(
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                color: AppColors.verylightgrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: List.generate(categories.length, (index) {
                        final title = categories[index];
                        return Utils.filterItem(
                          title: title,
                          value: selectedCategory == title,
                          //  title: categories[index]["title"],
                          // value: categories[index]["value"],
                          onTap: () {
                            setState(() {
                              selectedCategory = title;
                            });
                          },
                          //  onTap: () {
                          //    setState(() {
                          //      categories[index]["value"] =
                          //          !categories[index]["value"];
                          //    });
                          //  },
                          //  onChanged: (val) {
                          //    setState(() {
                          //      categories[index]["value"] = val ?? false;
                          //    });
                          //  },
                          onChanged: (_) {
                            setState(() {
                              selectedCategory = title;
                            });
                          },
                        );
                      }),
                    ),
                    SizedBox(height: 20.h,),
                    Text(
                      "Brands",
                      style: TextStyle(
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Column(
                      children: List.generate(brands.length, (index) {
                        final title = brands[index];
                        return Utils.filterItem(
                          title: title,
                          value: selectedBrand == title,
                          onTap: () {
                            setState(() {
                              selectedBrand = title;
                            });
                          },
                          onChanged: (_) {
                            setState(() {
                              selectedBrand = title;
                            });
                          },
                          // title: brands[index]["title"],
                          // value: brands[index]["value"],
                          // onTap: () {
                          //   brands[index]["value"] = !brands[index]["value"];
                          // },
                          // onChanged: (val) {
                          //   setState(() {
                          //     brands[index]["value"] = val ?? false;
                          //   });
                          // },
                        );
                      }),
                    ),SizedBox(height: 80.h,),
                    AppButtons.socialButton(
                      text: "Apply Fiter",bgColor: AppColors.primaryColor,
                      onPressed: () {
                        final _appliedText = selectedCategory ?? selectedBrand;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return FilteredproductsScreen(
                                appliedText: _appliedText ?? "",
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
