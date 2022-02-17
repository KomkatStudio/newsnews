import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/features/profile/presentation/widgets/custom_chip.dart';
import 'package:newsnews/src/features/profile/presentation/widgets/switch_user_control.dart';
import 'package:newsnews/src/features/profile/presentation/widgets/user_tab_control.dart';

import '../widgets/custom_stack_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationStatus = false;
  bool darkModeStatus = false;

  @override
  Widget build(BuildContext context) {
    final interestedList = ["Covid 19", "Entertainment", "Science"];
    final userTabControl = [
      {
        "tabName": "Preferences",
        "iconData": Icons.tune_rounded,
        "routeName": "/preferences",
      },
      {
        "tabName": "Abouts",
        "iconData": Icons.help_outline_rounded,
        "routeName": "/abouts",
      },
      {
        "tabName": "Privacy & security",
        "iconData": Icons.lock_outline_rounded,
        "routeName": "/p&s",
      },
      {
        "tabName": "Help & support",
        "iconData": Icons.headphones_outlined,
        "routeName": "/help",
      },
      {
        "tabName": "Log out",
        "iconData": Icons.logout_rounded,
        "routeName": "/logout",
      }
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 210.h,
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
                                      backgroundColor:
                                          Palette.textColorInBlueBGColor,
                                      child: IconButton(
                                        iconSize: 16.sp,
                                        icon: const FaIcon(
                                            FontAwesomeIcons.camera),
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
                                            color:
                                                Palette.textColorInBlueBGColor,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        IconButton(
                                          icon: const FaIcon(
                                              FontAwesomeIcons.pen),
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
                            fontSize: 20.sp,
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
                            return CustomChip(interest: interestedList[index]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SwitchUserControl(
                        status: notificationStatus,
                        onSwitchActionFunction: (value) => setState(() {
                          notificationStatus = !notificationStatus;
                        }),
                        label: 'Notification',
                      ),
                      SwitchUserControl(
                        label: 'Dark Mode',
                        isLast: true,
                        onSwitchActionFunction: (value) => setState(() {
                          darkModeStatus = !darkModeStatus;
                        }),
                        status: darkModeStatus,
                      ),
                      SizedBox(height: 15.h),
                      for (int i = 0; i < userTabControl.length; i++)
                        UserTabControl(
                          typeBorderRadius: i == 0
                              ? 0
                              : (i == userTabControl.length - 1 ? 1 : 2),
                          onTabNameFunction: () {},
                          tabName: userTabControl[i]["tabName"] as String,
                          iconData: userTabControl[i]["iconData"] as IconData,
                        )
                    ],
                  ),
                  Positioned(
                    top: 210.h - 50.h,
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
            ],
          ),
        ),
      ),
    );
  }
}
