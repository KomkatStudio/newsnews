import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/domain/entities/article_entity2.dart';
import 'package:newsnews/src/presentation/feed/cubit/news_cubit.dart';
import 'package:newsnews/src/widgets/circle_loading.dart';
import 'package:newsnews/src/widgets/custom_category_choice_chip.dart';
import 'package:newsnews/src/widgets/custom_error.dart';
import 'package:newsnews/src/widgets/news_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MoreNewAI extends StatefulWidget {
  final String? title;
  const MoreNewAI({Key? key, this.title}) : super(key: key);

  @override
  State<MoreNewAI> createState() => _MoreNewAIState();
}

class _MoreNewAIState extends State<MoreNewAI> {
  late List<ArticleEntity2> listFilter;
  final categoryList = ["All", "business", "life", "sports", "travel", "world"];
  var choseCategoryList = <bool>[];

  @override
  void initState() {
    if (widget.title == null) {
      choseCategoryList =
          List.filled(categoryList.length, false, growable: false)
            ..first = true;
    }
    final state = context.read<NewsCubit>().state;
    if (state is NewsLoaded) {
      if (widget.title == null) {
        listFilter = <ArticleEntity2>[...state.listAllFromAI];
      } else {
        listFilter = <ArticleEntity2>[
          ...state.listAllFromAI.where(
            (article) =>
                article.category!.toLowerCase() == widget.title!.toLowerCase(),
          )
        ];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(PhosphorIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(widget.title ?? "More Breaking News"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            splashRadius: 24,
            icon: const Icon(
              PhosphorIcons.arrowClockwise,
              color: Colors.black,
            ),
            onPressed: () => context.read<NewsCubit>().getArticles(),
          ),
        ],
      ),
      body: Column(
        children: [
          widget.title == null
              ? SizedBox(
                  height: 65.h,
                  child:
                      BlocSelector<NewsCubit, NewsState, List<ArticleEntity2>>(
                    selector: (state) {
                      return state is NewsLoaded ? state.listAllFromAI : [];
                    },
                    builder: (context, listAllFromAI) {
                      return ListView.builder(
                        padding:
                            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return CustomCategoryChoiceChip(
                            category: categoryList[index],
                            choiceStatus: choseCategoryList[index],
                            onSelectCategoryFunction: (value) => setState(() {
                              if (index == 0) {
                                choseCategoryList = List<bool>.filled(
                                    categoryList.length, false,
                                    growable: false)
                                  ..first = true;
                                listFilter.clear();
                                listFilter.addAll(listAllFromAI);
                              } else if (index != 0 &&
                                  !choseCategoryList[index]) {
                                choseCategoryList = List<bool>.filled(
                                    categoryList.length, false,
                                    growable: false);
                                choseCategoryList[index] = value;
                                choseCategoryList[0] = false;
                                listFilter.clear();
                                listFilter.addAll(listAllFromAI.where(
                                  (article) =>
                                      article.category!.toLowerCase() ==
                                      categoryList[index].toLowerCase(),
                                ));
                              }
                            }),
                          );
                        },
                      );
                    },
                  ),
                )
              : const SizedBox(),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      itemCount: listFilter.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 400),
                          child: SlideAnimation(
                            verticalOffset: 75.0,
                            child: FadeInAnimation(
                              child: NewsCard(
                                imageUrl: listFilter[index].imgUrl,
                                title: listFilter[index].title!,
                                tag: listFilter[index].category!,
                                time: DateTime.now(),
                                verticalMargin: 8.h,
                                needHeart: true,
                                isFavorite: false,
                                onHeartTapFunction: () {},
                                onNewsTapFunction: () => Navigator.pushNamed(
                                  context,
                                  RouteManager.detailArticle2,
                                  arguments: {
                                    "article": listFilter[index],
                                    "newsTag": listFilter[index].category,
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is NewsLoading) {
                  return const CircleLoading();
                } else {
                  return const CustomError(
                    messageError:
                        "Have a problem when loading news for you\nPlease try again",
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
