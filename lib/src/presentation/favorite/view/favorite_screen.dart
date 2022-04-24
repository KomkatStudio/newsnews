import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/widgets/custom_scroll.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
          titleTextStyle: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                PhosphorIcons.arrowClockwise,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: CustomScroll(),
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
            itemBuilder: (context, index) {
              // return NewsCard(
              //   imageUrl:
              //       "https://sportshub.cbsistatic.com/i/r/2021/01/22/4d145216-04f3-4ed7-bbfe-c19b8e2f8819/thumbnail/1200x675/5499"
              //       "4d3f30fed2fb6effc7e5b8ea14bb/rodgers-packers-snow.jpg",
              //   title:
              //       "Manchester City's Kevin De Bruyne will take time to be...",
              //   tag: "Sport",
              //   time: "15 mins ago",
              //   verticalMargin: 8.h,
              //   needHeart: true,
              //   isFavorite: true,
              //   onHeartTapFunction: () {},
              //   onNewsTapFunction: () {},
              // );
              return Container(
                height: 200.h,
                color: Colors.red,
              );
            },
          ),
        ));
  }
}
