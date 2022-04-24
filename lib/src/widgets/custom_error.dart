import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomError extends StatelessWidget {
  const CustomError({Key? key, this.messageError}) : super(key: key);

  final String? messageError;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          PhosphorIcons.warning,
          color: Palette.primaryColor,
        ),
        SizedBox(
          height: 5.h,
        ),
        messageError != null
            ? Text(
                messageError!,
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
