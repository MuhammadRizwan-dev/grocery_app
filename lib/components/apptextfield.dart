import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_app/components/utils.dart';

class Apptextfield extends StatelessWidget {
  final String? hint;
  final bool? isPassword;
  final Icon? icon;
  final String? label;
  final IconButton? suffixIcon;
  final double? fontSize;
  final ValueChanged<String>? onChanged; // typo fix
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const Apptextfield({
    super.key,
    this.hint,
    this.isPassword = false,
    this.controller,
    this.icon,
    this.keyboardType,
    this.label,
    this.suffixIcon,
    this.fontSize,
    this.labelStyle,
    this.onChanged,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isPassword ?? false,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next, // default next
        onFieldSubmitted: (_) {
          FocusScope.of(context).nextFocus();
        },
        textAlign: TextAlign.start,
        style: TextStyle(
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w400,
          fontSize: 17.sp,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle: labelStyle,
          hintStyle: TextStyle(
            color: AppColors.lightGrey,
            fontSize: fontSize,
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.lightGrey,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 0.w, vertical: 18.h),
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
