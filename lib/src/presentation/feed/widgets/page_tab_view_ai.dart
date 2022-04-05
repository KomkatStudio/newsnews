import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/view/more_breakings_news_ai.dart';
import 'package:newsnews/src/presentation/feed/widgets/big_tag.dart';
import 'package:newsnews/src/presentation/feed/widgets/headline_card.dart';
import 'package:newsnews/src/presentation/feed/widgets/row_tag_see_more.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:newsnews/src/widgets/news_card.dart';

class PageTabViewAI extends StatefulWidget {
  const PageTabViewAI({Key? key}) : super(key: key);

  @override
  State<PageTabViewAI> createState() => _PageTabViewAIState();
}

class _PageTabViewAIState extends State<PageTabViewAI>
    with SingleTickerProviderStateMixin {
  late final PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  void changePage(int value) {
    setState(() {
      currentPage = value;
    });
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
          i == currentPage ? _buildIndicator(true) : _buildIndicator(false));
    }
    return list;
  }

  Widget _buildIndicator(bool isChanged) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      height: 5.h,
      width: isChanged ? 35.w : 20.w,
      decoration: BoxDecoration(
        color: isChanged ? Palette.primaryHeavyColor : Palette.unSelectedColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewsCubit, NewsState, List<ArticleEntity2>>(
      selector: (state) {
        return state is NewsLoaded ? state.listAllFromAI : [];
      },
      builder: (context, listAllFromAI) {
        log(listAllFromAI.length.toString());
        // return const SizedBox();

        // log(listAllFromAI.length.toString());/
        final listForTop = listAllFromAI.getRange(0, 3).toList();
        log(listForTop.length.toString());

        final listForBreakingNews =
            listAllFromAI.getRange(3, listAllFromAI.length).toList();
        log(listForBreakingNews.length.toString());
        return ListView(
          children: [
            SizedBox(
              height: 24.h,
            ),
            BigTag(tag: "Top Headline", fontSize: 24.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 330.h,
              child: PageView.builder(
                onPageChanged: changePage,
                itemCount: listForTop.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return HeadlineCard(
                    imageURL: listForTop[index].imgUrl,
                    newsTag: listForTop[index].category!,
                    newsTitle: listForTop[index].title!,
                    onHeadlineTapFunction: () => Navigator.pushNamed(
                      context,
                      RouteManager.detailArticle2,
                      arguments: {
                        "article": listForTop[index],
                        "newsTag": listForTop[index].category,
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: _buildPageIndicator(),
            ),
            SizedBox(
              height: 14.h,
            ),
            RowTagSeeMore(
              tag: "Breaking news",
              onSeeMoreTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoreNewAI(),
                ),
              ),
            ),
            SizedBox(
              height: 400.h,
              child: ScrollConfiguration(
                behavior: CustomScroll(),
                child: ListView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  itemBuilder: (context, index) {
                    return NewsCard(
                        imageUrl: listForBreakingNews[index].imgUrl,
                        title: listForBreakingNews[index].title!,
                        tag: listForBreakingNews[index].category!,
                        time: DateTime.now(),
                        verticalMargin: 16.h,
                        onNewsTapFunction: () {
                          context.read<NewsCubit>().hitFavorite(
                                category: listForBreakingNews[index].category!,
                              );
                          Navigator.pushNamed(
                            context,
                            RouteManager.detailArticle2,
                            arguments: {
                              "article": listForBreakingNews[index],
                              "newsTag": listForBreakingNews[index].category!,
                            },
                          );
                        });
                  },
                ),
              ),
            ),
            // SizedBox(
            //   height: 8.h,
            // ),
            // RowTagSeeMore(
            //   tag: "Hot & trendings",
            //   onSeeMoreTap: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const HotAndTrendings(),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 150.h,
            //   child: ListView.builder(
            //     itemCount: 3,
            //     padding: EdgeInsets.symmetric(horizontal: 8.w),
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return NewsCard(
            //         imageUrl: listForHotTrendings[index].imgUrl ?? "",
            //         title: listForHotTrendings[index].title!,
            //         tag: listForHotTrendings[index].category!,
            //         time: DateTime.now(),
            //         verticalMargin: 16.h,
            //         onNewsTapFunction: () {
            //           context.read<NewsCubit>().hitFavorite(
            //               category: listForHotTrendings[index].category!);
            //           Navigator.pushNamed(
            //             context,
            //             RouteManager.detailArticle2,
            //             arguments: {
            //               "article": listForHotTrendings[index],
            //               "newsTag": listForHotTrendings[index].category!,
            //             },
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
            SizedBox(
              height: 14.h,
            ),
            const RowTagSeeMore(
              tag: "Ads",
              hasSeeMore: false,
            ),
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: 140.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: const Text("Ads"),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
