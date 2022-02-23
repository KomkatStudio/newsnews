import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class UserTabControl extends StatelessWidget {
  const UserTabControl({
    Key? key,
    required this.typeBorderRadius,
    required this.tabName,
    required this.onTabNameFunction,
    required this.iconData,
  }) : super(key: key);

  final int typeBorderRadius;
  final String tabName;
  final VoidCallback onTabNameFunction;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabNameFunction,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.5.h),
        height: 45.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: typeBorderRadius == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : (typeBorderRadius == 1
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : null),
          boxShadow: [
            BoxShadow(
              color: Palette.shadowColor.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(-1, 0),
            ),
            BoxShadow(
              color: Palette.shadowColor.withOpacity(0.1),
              blurRadius: 1,
              offset: const Offset(1, 0),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Palette.primaryColor,
            ),
            SizedBox(width: 12.w),
            Text(
              tabName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
