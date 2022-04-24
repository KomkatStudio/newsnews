import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/presentation/feed/widgets/big_tag.dart';

class RowTagSeeMore extends StatelessWidget {
  const RowTagSeeMore(
      {Key? key, required this.tag, this.hasSeeMore = true, this.onSeeMoreTap})
      : super(key: key);

  final String tag;
  final bool hasSeeMore;
  final VoidCallback? onSeeMoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BigTag(tag: tag, fontSize: 22.sp),
        hasSeeMore
            ? GestureDetector(
                onTap: onSeeMoreTap,
                child: Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: Text(
                    "See more",
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
