import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/view/more_news_for_you.dart';
import 'package:newsnews/src/presentation/feed/widgets/big_tag.dart';
import 'package:newsnews/src/presentation/feed/widgets/headline_card.dart';
import 'package:newsnews/src/presentation/feed/widgets/row_tag_see_more.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:newsnews/src/widgets/news_card.dart';

class PageTabViewForYou extends StatefulWidget {
  const PageTabViewForYou(
      {Key? key, required this.newsCubit, required this.listForYou})
      : super(key: key);
  final NewsCubit newsCubit;
  final List<ArticleEntity2> listForYou;

  @override
  State<PageTabViewForYou> createState() => _PageTabViewForYouState();
}

class _PageTabViewForYouState extends State<PageTabViewForYou>
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
    log(widget.listForYou.toString());
    final listForTop = widget.listForYou.getRange(0, 3).toList();
    log(listForTop.length.toString());

    final listMore =
        widget.listForYou.getRange(3, widget.listForYou.length).toList();
    return ScrollConfiguration(
      behavior: CustomScroll(),
      child: RefreshIndicator(
        onRefresh: () => widget.newsCubit.getArticles(),
        child: ListView(
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
                    onHeadlineTapFunction: () async => await context
                        .read<NewsCubit>()
                        .hitFavorite(category: listForTop[index].category!)
                        .then(
                          ((value) => Navigator.pushNamed(
                                context,
                                RouteManager.detailArticle2,
                                arguments: {
                                  "article": listForTop[index],
                                  "newsTag": listForTop[index].category!,
                                },
                              )),
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
                  builder: (context) => BlocProvider.value(
                    value: widget.newsCubit,
                    child: const MoreNewsForYou(
                      title: "More news for you",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150.h,
              child: ListView.builder(
                itemCount: listMore.length,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemBuilder: (context, index) {
                  return NewsCard(
                    imageUrl: listMore[index].imgUrl,
                    title: listMore[index].title!,
                    tag: listMore[index].category!,
                    time: DateTime.now(),
                    verticalMargin: 16.h,
                    onNewsTapFunction: () async => await context
                        .read<NewsCubit>()
                        .hitFavorite(category: listMore[index].category!)
                        .then(
                          ((value) => Navigator.pushNamed(
                                context,
                                RouteManager.detailArticle2,
                                arguments: {
                                  "article": listMore[index],
                                  "newsTag": listMore[index].category!,
                                },
                              )),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
