import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/features/feed/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/widgets/circle_loading.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 6);
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
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.blue, width: 3),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 6.w),
                    child: Text(
                      "Top Headline",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: Image.network(
                                      "https://www.reuters.com/resizer/T2bX-QG7Lo0g5TfWkk2KdqlSCs0=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PG6LBB7KM5LJHKHOD3BHBR3IAE.jpg",
                                    ).image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                margin: EdgeInsets.only(bottom: 15.h),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 20.w,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade800,
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Covid 19".toUpperCase(),
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          child: Text(
                            "Covid 19 in children occurs mostly for a short duration, finds study",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
