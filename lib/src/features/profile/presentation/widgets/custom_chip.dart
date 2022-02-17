import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.interest,
  }) : super(key: key);

  final String interest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Chip(
        label: Text(interest),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: Palette.primaryColor,
            width: 1.2,
          ),
        ),
        labelStyle: TextStyle(
          color: Palette.primaryTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.blue.shade50.withOpacity(0.1),
      ),
    );
  }
}
