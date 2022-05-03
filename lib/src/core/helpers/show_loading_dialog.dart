import 'package:flutter/material.dart';
import 'package:newsnews/src/core/theme/palette.dart';

showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: Palette.primaryColor,
        ),
      );
    },
  );
}
