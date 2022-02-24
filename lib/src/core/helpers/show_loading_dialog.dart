import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

showLoadingDialog(BuildContext context, {String? contentDialog}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Palette.primaryColor,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                contentDialog ?? "Loading...",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      });
}
