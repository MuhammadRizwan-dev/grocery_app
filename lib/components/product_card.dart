import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                  ? Image.network(item["image"]!, height: 90.h, fit: BoxFit.contain)
                  : Image.asset(item["image"]!, height: 90.h, fit: BoxFit.contain),
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
                  "\$${item["price"]}",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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