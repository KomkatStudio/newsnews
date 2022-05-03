import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class SwitchUserControl extends StatelessWidget {
  const SwitchUserControl({
    Key? key,
    required this.status,
    required this.onSwitchActionFunction,
    required this.label,
    this.isLast = false,
  }) : super(key: key);

  final bool status;
  final ValueChanged<bool> onSwitchActionFunction;
  final String label;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 0.5.h),
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isLast
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
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
      padding: EdgeInsets.only(left: 16.w, right: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: Palette.textColor,
            ),
          ),
          Switch(
            activeColor: Palette.primaryColor,
            onChanged: onSwitchActionFunction,
            value: status,
          ),
        ],
      ),
    );
  }
}
