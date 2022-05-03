import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/constant/numberic_constant.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/article/article_entity.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/presentation/feed/view/hot_and_trendings.dart';
import 'package:newsnews/src/presentation/feed/view/more_breaking_news.dart';
import 'package:newsnews/src/presentation/feed/widgets/big_tag.dart';
import 'package:newsnews/src/presentation/feed/widgets/headline_card.dart';
import 'package:newsnews/src/presentation/feed/widgets/row_tag_see_more.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:newsnews/src/widgets/news_card.dart';

class PageTabView extends StatefulWidget {
  const PageTabView({Key? key}) : super(key: key);

  @override
  State<PageTabView> createState() => _PageTabViewState();
}

class _PageTabViewState extends State<PageTabView>
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
    return BlocSelector<NewsCubit, NewsState, List<ArticleEntity>>(
      selector: (state) {
        return state is NewsLoaded ? state.listArticle : [];
      },
      builder: (context, listArticle) {
        final tagArticleList = listArticle
            .getRange(0, NumbericContant.pageSizeForToplines)
            .toList();
        // log(tagArticleList.length.toString());
        final listForTop = tagArticleList.getRange(0, 3).toList();
        // log(listForTop.length.toString());

        final listForBreakingNews = tagArticleList.getRange(3, 7).toList();
        // log(listForBreakingNews.length.toString());

        final listForHotTrendings = tagArticleList.getRange(7, 11).toList();
        // log(listForHotTrendings.length.toString());
        return ScrollConfiguration(
          behavior: CustomScroll(),
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
                      imageURL: listForTop[index].urlToImage,
                      newsTag: "EVERYTHING",
                      newsTitle: listForTop[index].title!,
                      onHeadlineTapFunction: () => context.go(
                        RouteManager.detailArticle,
                        extra: <String, dynamic>{
                          "article": listForTop[index],
                          "newsTag": "EVERYTHING",
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
                    builder: (context) => const MoreNews(),
                  ),
                ),
              ),
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      imageUrl: listForBreakingNews[index].urlToImage,
                      title: listForBreakingNews[index].title!,
                      tag: "EVERYTHING",
                      time: listForBreakingNews[index].publishedAt,
                      verticalMargin: 16.h,
                      onNewsTapFunction: () => context.go(
                        RouteManager.detailArticle,
                        extra: <String, dynamic>{
                          "article": listForBreakingNews[index],
                          "newsTag": "EVERYTHING",
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              RowTagSeeMore(
                tag: "Hot & trendings",
                onSeeMoreTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HotAndTrendings(),
                  ),
                ),
              ),
              SizedBox(
                height: 150.h,
                child: ListView.builder(
                  itemCount: 3,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      imageUrl: listForHotTrendings[index].urlToImage ?? "",
                      title: listForHotTrendings[index].title!,
                      tag: "EVERYTHING",
                      time: listForBreakingNews[index].publishedAt,
                      verticalMargin: 16.h,
                      onNewsTapFunction: () => context.go(
                        RouteManager.detailArticle,
                        extra: <String, dynamic>{
                          "article": listForHotTrendings[index],
                          "newsTag": "EVERYTHING",
                        },
                      ),
                    );
                  },
                ),
              ),
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
          ),
        );
      },
    );
  }
}
