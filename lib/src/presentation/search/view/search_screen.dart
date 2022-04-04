import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
         
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(vertical: 12.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Palette.backgroundBoxColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Palette.shadowColor.withOpacity(0.1),
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: TextField(
                  style: TextStyle(fontSize: 18.sp),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.only(left: 14.w),
                    hintText: "Type to search",
                    suffixIcon: const Icon(
                      PhosphorIcons.magnifyingGlass,
                    ),
                    hintStyle: TextStyle(fontSize: 16.sp),
                    border: InputBorder.none,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
