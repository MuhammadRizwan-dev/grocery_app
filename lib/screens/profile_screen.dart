import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/components/utils.dart';

import 'my_order_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
 // final user = FirebaseAuth.instance.currentUser;
  User? user = FirebaseAuth.instance.currentUser;
  String displayEmail = "Loading...";
  File? profileImage;
  bool isUploading = false;
  bool isLoggingOut = false;
  @override
  void initState() {
    super.initState();
    refreshUser();
  }
  void refreshUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
    var doc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    if (mounted) {
      setState(() {
        user = FirebaseAuth.instance.currentUser;
        displayEmail = doc.data()?['email'] ?? user?.email ?? 'No Email';
      });
    }
  }
  void selectProfileImage() async {
    final picked = await Utils.pickImage();
    if (picked != null) {
      setState(() {
        profileImage = picked;
      });
      await uploadImageToCloudinary(picked);
    }
  }

  Future<void> uploadImageToCloudinary(File image) async {
    if (user == null) return;
    setState(() => isUploading = true);
    final cloudinary = CloudinaryPublic(
      'dckqdadpm',
      'grocery_preset',
      cache: false,
    );
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: "user_profiles"),
      );
      String imageUrl = response.secureUrl;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'photoUrl': imageUrl});
      if (!mounted) return;
      Utils.showSnackBar(
        "Profile Image Uploaded Successfully",
        color: Colors.green,
      );
    } catch (e) {
      print("Upload Error:$e");
      if (!mounted) return;
      Utils.showSnackBar("Profile Image Upload Failed", color: Colors.red);
    } finally {
      if (mounted) {
        setState(() => isUploading = false);
      }
    }
  }

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
                  GestureDetector(
                    onTap: isUploading ? null : selectProfileImage,
                    child: CircleAvatar(
                      radius: 32.r,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : (user?.photoURL != null
                                ? NetworkImage(user!.photoURL!)
                                : null),
                      child: (profileImage == null && user?.photoURL == null)
                          ? Icon(Icons.person, color: Colors.white, size: 32.sp)
                          : (isUploading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : null),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.displayName ?? 'user',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        displayEmail,
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
                  onTap: (){
                    Get.to(() => const MyOrdersScreen());
                  },
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
                child: ElevatedButton(
                  onPressed: (isLoggingOut || isUploading)
                      ? null
                      : () async {
                          setState(() => isLoggingOut = true);
                          await Utils.signOut();
                          //   try {
                          //     await FirebaseAuth.instance.signOut();
                          //     Get.offAll(() =>const WelcomeScreen());
                          //   } catch (e) {
                          //     Utils.showSnackBar(
                          //       "LogOut Failed : $e",
                          //       color: Colors.red,
                          //     );
                          //   } finally {
                          if (mounted) setState(() => isLoggingOut = false);
                          //   }
                          // },
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: isLoggingOut
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 2,
                          ),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            Text(
                              'Log Out',
                              style: TextStyle(
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
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
