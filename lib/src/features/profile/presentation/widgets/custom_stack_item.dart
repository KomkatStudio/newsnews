import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF334D6E),
            blurRadius: 14,
            offset: Offset(0.5, -0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24.sp,
            backgroundColor: Colors.blue.shade100.withOpacity(0.3),
            child: FaIcon(
              icon,
              color: Palette.primaryColor,
            ),
          ),
          SizedBox(
            width: 25.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${itemCounter ?? 0}",
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  color: Palette.primaryTextColor,
                ),
              ),
              Text(
                itemName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Palette.primaryTextColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
