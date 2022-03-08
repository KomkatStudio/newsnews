import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PrivacyScreenScreen extends StatelessWidget {
  const PrivacyScreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          iconSize: 22,
        ),
        title: const Text("Privacy & security"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        elevation: 2,
      ),
    );
  }
}
