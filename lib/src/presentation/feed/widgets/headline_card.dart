import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/custom_cache_manager.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/widgets/custom_error.dart';

class HeadlineCard extends StatelessWidget {
  const HeadlineCard({
    Key? key,
    required this.newsTitle,
    required this.newsTag,
    this.imageURL,
    required this.onHeadlineTapFunction,
  }) : super(key: key);

  final String newsTitle;
  final String newsTag;
  final String? imageURL;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Hero(
                  tag: newsTitle + "_" + newsTag,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      cacheManager: CustomCacheManager.customCacheManager,
                      imageUrl: imageURL ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(bottom: 10.h),
                      ),
                      progressIndicatorBuilder: (context, string, progress) {
                        return Container(
                          height: 200.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: Palette.primaryColor,
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 10.h),
                        );
                      },
                      errorWidget: (context, string, dymamic) => Container(
                        height: 200.h,
                        child: const Center(
                          child: CustomError(
                            messageError: "This no image or fail",
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 10.h),
                      ),
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
            const Spacer(),
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
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
