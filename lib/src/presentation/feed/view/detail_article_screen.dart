import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DetailArticleScreen extends StatefulWidget {
  const DetailArticleScreen({Key? key}) : super(key: key);

  @override
  State<DetailArticleScreen> createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  bool isChanged = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(height: 405.h),
              Container(
                height: 370.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: Image.network(
                      "https://www.reuters.com/resizer/T2bX-QG7Lo0g5TfWkk2KdqlSCs0=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PG6LBB7KM5LJHKHOD3BHBR3IAE.jpg",
                    ).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 370.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Palette.primaryHeavyColor.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0.2,
                      1,
                    ],
                  ),
                ),
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 8.h,
                  bottom: 18.h,
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundColor:
                              Palette.backgroundBoxColor.withOpacity(0.7),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 22.sp,
                            icon: const Icon(PhosphorIcons.arrowLeftBold),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.backgroundInDetailBoxColor.shade800,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: const Text(
                          "COVID 19",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Palette.backgroundBoxColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 15.h,
                          bottom: 10.h,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Palette.backgroundBoxColor,
                              width: 3.5,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "COVID-19 in children occurs mostly for a short duration, finds study",
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 22.sp,
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w700,
                              color: Palette.backgroundBoxColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 35.w / 2,
                right: 25.w,
                child: Row(
                  children: [
                    Container(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.backgroundBoxColor,
                        boxShadow: [
                          BoxShadow(
                            color: Palette.shadowColor.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(1, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(PhosphorIcons.exportBold),
                        color: Palette.primaryLowerColor,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Container(
                      height: 35.w,
                      width: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Palette.backgroundBoxColor,
                        boxShadow: [
                          BoxShadow(
                            color: Palette.shadowColor.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(1, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(PhosphorIcons.heartBold),
                        color: Palette.primaryLowerColor,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
