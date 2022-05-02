import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/custom_cache_manager.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/widgets/custom_error.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:newsnews/src/widgets/news_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DetailArticleScreenForYou extends StatelessWidget {
  const DetailArticleScreenForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ArticleEntity2 article = argument['article'];
    final newsTag = argument["newsTag"] as String;
    return BlocSelector<NewsCubit, NewsState, List<ArticleEntity2>>(
      selector: (state) {
        return state is NewsLoaded ? state.listAllFromAI : [];
      },
      builder: (context, listAllFromAI) {
        return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 390.h,
                  ),
                  Hero(
                    tag: article.title! + "_" + newsTag,
                    child: CachedNetworkImage(
                      cacheManager: CustomCacheManager.customCacheManager,
                      imageUrl: article.imgUrl ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        height: 370.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(25),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder: (context, string, progress) {
                        return Container(
                          height: 370.h,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: Palette.primaryColor,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, string, dymamic) => Container(
                        height: 370.h,
                        child: const Center(
                          child: CustomError(),
                        ),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(25),
                          ),
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
                              color:
                                  Palette.backgroundInDetailBoxColor.shade800,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: Text(
                              newsTag.toUpperCase(),
                              style: const TextStyle(
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
                              article.title!,
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
                                offset: const Offset(0, 3),
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
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Description",
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
                                        text: article.description?.replaceAll(
                                                RegExp(r'\[.*\]'), '') ??
                                            "No description here, please read it in ",
                                      ),
                                      TextSpan(
                                        text: "\tRead more",
                                        style: TextStyle(
                                          color: Palette.primaryHeavyColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 19.sp,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(
                                                context,
                                                RouteManager.webview,
                                                arguments: {
                                                  'title': article.title,
                                                  'urlLink': article.link,
                                                },
                                              ),
                                      )
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
                          ),
                        ),
                        SizedBox(height: 5.h),
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
                          height: 150.h,
                          child: ListView.builder(
                            itemCount: 4,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final indexRandom =
                                  Random().nextInt(listAllFromAI.length - 1);
                              return NewsCard(
                                imageUrl: listAllFromAI[indexRandom].imgUrl,
                                title: listAllFromAI[indexRandom].title!,
                                tag: listAllFromAI[indexRandom].category!,
                                time: DateTime.now(),
                                verticalMargin: 16.h,
                                onNewsTapFunction: () {
                                  // context.read<NewsCubit>().hitFavorite(
                                  //       category: listAllFromAI[indexRandom]
                                  //           .category!,
                                  //     );
                                  Navigator.popAndPushNamed(
                                    context,
                                    RouteManager.detailArticle2,
                                    arguments: {
                                      "article": listAllFromAI[indexRandom],
                                      "newsTag":
                                          listAllFromAI[indexRandom].category,
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
