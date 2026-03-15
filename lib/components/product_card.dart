import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        margin: EdgeInsets.only(right: 16.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Color(0xFFE2E2E2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: item["isNetwork"] == true
                  ? CachedNetworkImage(
                      imageUrl: item["image"]!,
                      height: 80.h,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(height: 80.h, color: Colors.white),
                      ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.broken_image, size: 40.h),
                    )
                  : Image.asset(
                      item["image"]!,
                      height: 90.h,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(height: 12.h),
            Text(
              item["name"]!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              item["details"] ?? item["detail"] ?? "",
              style: TextStyle(fontSize: 14.sp, color: Color(0xFF7C7C7C)),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${item["price"].toString()}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    height: 36.h,
                    width: 36.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF53B175),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 18.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
