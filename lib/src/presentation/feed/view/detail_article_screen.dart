import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:newsnews/src/core/extension/extension.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/widgets/animated_effect_size.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:newsnews/src/widgets/news_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DetailArticleScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  const DetailArticleScreen(
      {Key? key, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  State<DetailArticleScreen> createState() => _DetailArticleScreenState();
}

class _DetailArticleScreenState extends State<DetailArticleScreen> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 390.h,
              ),
              Hero(
                tag: widget.imageUrl,
                child: Container(
                  height: 370.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: Image.network(
                        widget.imageUrl,
                      ).image,
                      fit: BoxFit.cover,
                    ),
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
                  bottom: 15.h,
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
                            splashRadius: 24.r,
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
                          widget.title,
                          style: TextStyle(
                            height: 1.4,
                            fontSize: 24.sp,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: Palette.backgroundBoxColor,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 35.h / 2 - 12.h,
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
                        splashRadius: 24.r,
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
                        splashRadius: 24.r,
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
              child: ScrollConfiguration(
                behavior: CustomScroll(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                PhosphorIcons.calendar,
                                color: Palette.primaryColor,
                                size: 28.sp,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "2022-02-28T21:01:00Z".convertToDateTime(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Palette.primaryColor,
                                    width: 1.5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: Image.network(
                                          "https://is3-ssl.mzstatic.com/image/thumb/Purple116/v4/a1/b3/df/a1b3df5b-294e-56f2-7ab7-33fbcad50095/source/512x512bb.jpg")
                                      .image,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "KCRA Sacramento",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: AnimatedEffectSize(
                        child: isExpand
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Content",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Estée Lauder Cos. has fired John Demsey, a senior "
                                                    "executive who last week posted a meme on his personal "
                                                    "Instagram account that contained a racial "
                                                    "slur and a joke about Covid-19.\r\nThe company announce… [+301 chars]"
                                                .replaceAll(RegExp(r'\[.*\]'), ''),
                                          ),
                                          TextSpan(
                                              text: "\tRead more",
                                              style: TextStyle(
                                                color:
                                                    Palette.primaryHeavyColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19.sp,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {})
                                        ],
                                      ),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        height: 1.8.h,
                                        letterSpacing: 0.15,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    'What are the common COVID-19 symptoms you can get from BA.2 '
                                    'variant or long COVID? Read about the COVID-19 symptoms you can '
                                    'experience now.',
                                    style: TextStyle(
                                      height: 1.8.h,
                                      fontSize: 18.sp,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      isExpand = true;
                                    }),
                                    child: Center(
                                      child: Text(
                                        'Read content',
                                        style: TextStyle(
                                          color: Palette.primaryHeavyColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.sp,
                                          height: 1.h,
                                          letterSpacing: 0.15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Center(
                      child: AnimatedRotation(
                        turns: isExpand ? 0.5 : 0,
                        curve: Curves.bounceInOut,
                        duration: const Duration(milliseconds: 500),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(PhosphorIcons.caretDownBold),
                          splashRadius: 24.r,
                          iconSize: 28.sp,
                          onPressed: () => setState(() {
                            isExpand = !isExpand;
                          }),
                          color: Palette.primaryHeavyColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Text(
                        "Authour",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 12.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          color: Palette.primaryLowerColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            height: 70.h,
                            width: 70.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Palette.primaryColor,
                                width: 2.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(3),
                            child: const CircleAvatar(
                              backgroundColor: Palette.backgroundBoxColor,
                              backgroundImage: Svg('assets/images/avatar.svg'),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sharon Terlep",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Posted on " +
                                      "2022-02-28T21:01:00Z"
                                          .convertToMMddyyy() +
                                      " (UTC)",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "People also read",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "See more",
                              style: TextStyle(
                                color: Palette.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: 140.h,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        scrollDirection: Axis.horizontal,
                        children: [
                          NewsCard(
                            imageUrl:
                                'https://sportshub.cbsistatic.com/i/r/2021/01/22/'
                                '4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg',
                            title:
                                "Manchester City's Kevin De Bruyne will take time to be...",
                            tag: "Sport",
                            time: "15 mins ago",
                            verticalMargin: 12.h,
                            onNewsTapFunction: () {},
                          ),
                          NewsCard(
                            imageUrl:
                                "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/5499"
                                "4d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                            title:
                                "Manchester City's Kevin De Bruyne will take time to be...",
                            tag: "Sport",
                            time: "15 mins ago",
                            verticalMargin: 12.h,
                            onNewsTapFunction: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
