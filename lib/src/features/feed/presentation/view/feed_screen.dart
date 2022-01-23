import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/features/feed/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/features/feed/presentation/widget/headline_card.dart';
import 'package:newsnews/src/features/feed/presentation/widget/news_card.dart';
import 'package:newsnews/src/widgets/circle_loading.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 6);
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        title: const Text("NewsNews"),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.grey.shade300,
          labelColor: Colors.black87,
          indicatorWeight: 3,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: "home".toUpperCase()),
            Tab(text: "covid-19".toUpperCase()),
            Tab(text: "Polities".toUpperCase()),
            Tab(text: "sport".toUpperCase()),
            Tab(text: "bussiness".toUpperCase()),
            Tab(text: "health".toUpperCase()),
          ],
        ),
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const CircleLoading();
          } else if (state is NewsError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is NewsLoaded) {
            return ListView(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                _buildBigTag(tag: "Top Headline", fontSize: 24.sp),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height: 320.h,
                  child: PageView(
                    controller: pageController,
                    children: const [
                      HeadlineCard(
                        imageURL:
                            "https://www.reuters.com/resizer/T2bX-QG7Lo0g5TfWkk2KdqlSCs0=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PG6LBB7KM5LJHKHOD3BHBR3IAE.jpg",
                        newsTag: "Covid 19",
                        newsTitle:
                            "Covid 19 in children occurs mostly for a short duration, finds study",
                      ),
                      HeadlineCard(
                        imageURL:
                            "https://www.reuters.com/resizer/T2bX-QG7Lo0g5TfWkk2KdqlSCs0=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PG6LBB7KM5LJHKHOD3BHBR3IAE.jpg",
                        newsTag: "Covid 19",
                        newsTitle:
                            "Covid 19 in children occurs mostly for a short duration, finds study",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                _buildRowTagSeeMore(tag: "Breaking news"),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: 140.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {
                          pageController.nextPage(
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                _buildRowTagSeeMore(tag: "Hot & trendings"),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: 140.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {},
                      ),
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {},
                      ),
                    ],
                  ),
                ),
                _buildRowTagSeeMore(tag: "Ads", hasSeeMore: false),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: 140.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {},
                      ),
                      NewsCard(
                        imageUrl:
                            "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/54994d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                        title:
                            "Manchester City's Kevin De Bruyne will take time to be...",
                        tag: "Sport",
                        time: "15 mins ago",
                        onNewsTapFunction: () {},
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildRowTagSeeMore(
      {required String tag,
      bool hasSeeMore = true,
      VoidCallback? onSeeMoreTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBigTag(tag: tag, fontSize: 22.sp),
        hasSeeMore
            ? GestureDetector(
                onTap: onSeeMoreTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Text(
                    "See more",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildBigTag({required String tag, required double fontSize}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.blue.shade800, width: 3.5),
        ),
      ),
      padding: EdgeInsets.only(left: 6.w),
      child: Text(
        tag,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
