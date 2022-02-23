import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class CustomStackItem extends StatelessWidget {
  const CustomStackItem({
    Key? key,
    required this.itemName,
    this.itemCounter,
    required this.icon,
  }) : super(key: key);

  final String itemName;
  final int? itemCounter;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Palette.backgroundBoxColor,
        boxShadow: [
          BoxShadow(
            color: Palette.shadowColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Expanded(
            child: CircleAvatar(
              radius: 24.sp,
              backgroundColor: Colors.blue.shade100.withOpacity(0.3),
              child: Icon(
                icon,
                color: Palette.primaryColor,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${itemCounter ?? 0}",
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
