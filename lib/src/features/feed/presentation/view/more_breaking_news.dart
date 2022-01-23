import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoreBreakingNews extends StatelessWidget {
  const MoreBreakingNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
          iconSize: 22,
        ),
        title: const Text("Breaking News"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.redoAlt,
              size: 22,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
