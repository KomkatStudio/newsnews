import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/custom_cache_manager.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/widgets/custom_error.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:newsnews/src/core/extension/extension.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    this.imageUrl,
    required this.title,
    required this.tag,
    this.time,
    required this.onNewsTapFunction,
    required this.verticalMargin,
    this.needHeart = false,
    this.onHeartTapFunction,
    this.isFavorite = false,
  }) : super(key: key);

  final String? imageUrl;
  final String title;
  final String tag;
  final DateTime? time;
  final double verticalMargin;
  final bool needHeart;
  final bool isFavorite;
  final VoidCallback? onHeartTapFunction;
  final VoidCallback onNewsTapFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onNewsTapFunction,
      child: Container(
        height: needHeart ? 120.h : 110.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: verticalMargin,
        ),
        width: 0.9.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
              child: Hero(
                tag: title + "_" + tag,
                child: CachedNetworkImage(
                  cacheManager: CustomCacheManager.customCacheManager,
                  imageUrl: imageUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // margin: EdgeInsets.only(bottom: 10.h),
                  ),
                  progressIndicatorBuilder: (context, string, progress) {
                    return SizedBox(
                      height: 200.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          color: Palette.primaryColor,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, string, dymamic) => SizedBox(
                    height: 200.h,
                    child: const Center(
                      child: CustomError(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  needHeart
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0.h),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Icon(
                                isFavorite
                                    ? PhosphorIcons.heartFill
                                    : PhosphorIcons.heart,
                                size: 26.sp,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onTap: onHeartTapFunction,
                            ),
                          ),
                        )
                      : const Spacer(flex: 2),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: tag.toUppercaseFirstLetter(),
                        child: Container(
                          height: 30.h,
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
                              tag.toUppercaseFirstLetter(),
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
                      const Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            PhosphorIcons.clock,
                            color: Palette.primaryColor,
                          ),
                          Text(
                            time?.getTimeAgo() ?? "Recently",
                            style: TextStyle(
                              color: Palette.descriptionColor,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
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
