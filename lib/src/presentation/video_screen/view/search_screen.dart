import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Search"),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              PhosphorIcons.magnifyingGlass,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(),
    );
  }
}
