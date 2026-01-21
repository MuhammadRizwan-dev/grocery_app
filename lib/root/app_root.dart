import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/components/utils.dart';
import 'package:grocery_app/screens/favourite_screen.dart';
import 'package:grocery_app/screens/profile_screen.dart';
import '../screens/shop_screen.dart';
import '../screens/search_screen.dart';
import '../screens/cart_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int currentIndex = 0;

  final List<Widget> screens = [
    ShopScreen(),
    SearchScreen(),
    CartScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,           // important for 5 items
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightGrey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/store.svg",
              colorFilter: ColorFilter.mode(
                AppColors.lightGrey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/store.svg",
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Group 3.svg",
              colorFilter: ColorFilter.mode(
                AppColors.lightGrey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/Group 3.svg",
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/user 1.svg",
              colorFilter: ColorFilter.mode(
                AppColors.lightGrey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/user 1.svg",
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
