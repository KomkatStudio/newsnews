import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class SignInWithButton extends StatelessWidget {
  const SignInWithButton({
    Key? key,
    required this.logoPath,
    required this.logoName,
    required this.onPressFunction,
  }) : super(key: key);

  final String logoPath;
  final String logoName;
  final VoidCallback onPressFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressFunction,
      child: Container(
        height: 55.h,
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.backgroundBoxColor,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox.square(
                  dimension: 28.sp,
                  child: SvgPicture.asset(logoPath),
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Sign in with $logoName",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
