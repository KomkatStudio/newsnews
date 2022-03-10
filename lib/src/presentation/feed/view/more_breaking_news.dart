import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/widgets/custom_category_choice_chip.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MoreBreakingNews extends StatefulWidget {
  const MoreBreakingNews({Key? key}) : super(key: key);

  @override
  State<MoreBreakingNews> createState() => _MoreBreakingNewsState();
}

class _MoreBreakingNewsState extends State<MoreBreakingNews> {
  final categoryList = [
    "All",
    "Covid-19",
    "Business",
    "Entertainment",
    "Health",
    "Technology",
    "Science",
    "Sports"
  ];
  var choseCategoryList = <bool>[];

  @override
  void initState() {
    choseCategoryList = List.filled(categoryList.length, false, growable: false)
      ..first = true;
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
        title: const Text("More breaking news"),
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
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
            child: ScrollConfiguration(
              behavior: CustomScroll(),
              child: ListView.builder(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return CustomCategoryChoiceChip(
                    category: categoryList[index],
                    choiceStatus: choseCategoryList[index],
                    onSelectCategoryFunction: (value) => setState(() {
                      if (index == 0 && !choseCategoryList[index]) {
                        choseCategoryList = List<bool>.filled(
                            categoryList.length, false,
                            growable: false)
                          ..first = true;
                      } else if (index != 0) {
                        choseCategoryList[index] = value;
                        choseCategoryList[0] = false;
                      }
                    }),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
                behavior: CustomScroll(),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      //   return NewsCard(
                      //     imageUrl:
                      //         "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/5499"
                      //         "4d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
                      //     title:
                      //         "Manchester City's Kevin De Bruyne will take time to be...",
                      //     tag: "Sport",
                      //     time: "15 mins ago",
                      //     verticalMargin: 8.h,
                      //     needHeart: true,
                      //     isFavorite: false,
                      //     onHeartTapFunction: () {},
                      //     onNewsTapFunction: () {},
                      //   );
                      // },
                      return Container(height: 200.h, color: Colors.red);
                    })),
          )
        ],
      ),
    );
  }
}
