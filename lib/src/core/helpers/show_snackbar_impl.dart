import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

showSnackbarImpl(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Palette.primaryColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: Palette.backgroundBoxColor,
  ));
}
