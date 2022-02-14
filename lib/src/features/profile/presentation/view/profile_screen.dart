import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/core/theme/palette.dart';

import '../widgets/custom_stack_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final interestedList = ["Covid 19", "Entertainment", "Science"];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 230.h,
                  width: ScreenUtil().screenWidth,
                  color: Palette.primaryColor,
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: 90.h,
                                width: 90.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Palette.tagInSpecifiedColor,
                                    width: 2.5,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(3.5),
                                child: CircleAvatar(
                                  backgroundImage: Image.network(
                                          "https://avatars.githubuserconten"
                                          "t.com/u/63831488?v=4")
                                      .image,
                                ),
                              ),
                              CircleAvatar(
                                radius: 16.sp,
                                backgroundColor: Palette.textColorInBlueBGColor,
                                child: IconButton(
                                  iconSize: 16.sp,
                                  icon: const FaIcon(FontAwesomeIcons.camera),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Nguyễn Minh Dũng",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Palette.textColorInBlueBGColor,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.pen),
                                    color: Palette.textColorInBlueBGColor,
                                    iconSize: 18.sp,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Text(
                                "ngminhdung1311@gmail.com",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Palette.textColorInBlueBGColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 75.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.w, bottom: 8.h),
                  child: Text(
                    "Interest",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: interestedList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Chip(
                          label: Text(interestedList[index]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Palette.primaryColor,
                              width: 1.2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          backgroundColor: Colors.blue.shade50.withOpacity(0.2),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(-1, 0),
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(1, 0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Notification",
                    style: TextStyle(
                      color: Color(0xff403B3B),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(-1, 0),
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(1, 0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 230.h - 50.h,
              width: ScreenUtil().screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CustomStackItem(
                    itemName: 'Favorites',
                    icon: FontAwesomeIcons.heart,
                    itemCounter: 100,
                  ),
                  CustomStackItem(
                    itemName: 'Likes',
                    icon: FontAwesomeIcons.thumbsUp,
                    itemCounter: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
