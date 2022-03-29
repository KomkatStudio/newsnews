import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class BigTag extends StatelessWidget {
  const BigTag({Key? key, required this.tag, required this.fontSize})
      : super(key: key);

  final String tag;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Palette.primaryHeavyColor, width: 3.5),
        ),
      ),
      padding: EdgeInsets.only(left: 6.w),
      child: Text(
        tag,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
