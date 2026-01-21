import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32.r,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, color: Colors.white, size: 32.sp),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muhammad Rizwan',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'rizwan@email.com',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(color: Colors.grey.shade300),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: Icon(Icons.shopping_bag_outlined),
                  title: Text(
                    'Orders',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(
                    'My Details',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(
                    'Delivery Address',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.payment_outlined),
                  title: Text(
                    'Payment Methods',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.local_offer_outlined),
                  title: Text(
                    'Promo Code',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.notifications_none_outlined),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text(
                    'Help',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                Divider(),

                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text(
                    'About',
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: Icon(Icons.logout, color: AppColors.primaryColor),
                  label: Text(
                    'Log Out',
                    style: TextStyle(
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
