import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/core/theme/palette.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.tag,
    required this.time,
    required this.onNewsTapFunction,
    required this.verticalMargin,
    this.needHeart = false,
    this.onHeartTapFunction,
    this.isFavorite = false,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String tag;
  final String time;
  final double verticalMargin;
  final bool needHeart;
  final bool isFavorite;
  final VoidCallback? onHeartTapFunction;
  final VoidCallback onNewsTapFunction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onNewsTapFunction,
      child: Container(
        height: needHeart ? 150.h : 130.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: 5.w),
        width: size.width - 35.w,
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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0.w),
                child: Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: Image.network(
                        imageUrl,
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: needHeart
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  needHeart
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: FaIcon(
                                isFavorite
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                size: 20.sp,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onTap: onHeartTapFunction,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        message: tag,
                        child: Container(
                          height: 30.h,
                          width: 70.w,
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Palette.backgroundChipColor,
                            border: Border.all(
                              color: Palette.primaryColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              tag,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Palette.tagCategoryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: Palette.primaryColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            time,
                            style: TextStyle(
                              color: Palette.descriptionColor,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
