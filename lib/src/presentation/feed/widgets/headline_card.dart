import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class HeadlineCard extends StatelessWidget {
  const HeadlineCard({
    Key? key,
    required this.newsTitle,
    required this.newsTag,
    required this.imageURL,
    required this.onHeadlineTapFunction,
  }) : super(key: key);

  final String newsTitle;
  final String newsTag;
  final String imageURL;
  final VoidCallback onHeadlineTapFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onHeadlineTapFunction,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 14,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: imageURL,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image.network(imageURL).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 12.h),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2.h,
                  left: 20.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.primaryHeavyColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      newsTag.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                newsTitle,
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
