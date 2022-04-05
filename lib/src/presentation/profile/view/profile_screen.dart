import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/helpers/show_loading_dialog.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/presentation/profile/cubit/theme_cubit.dart';
import 'package:newsnews/src/presentation/profile/view/edit_profile_screen.dart';
import 'package:newsnews/src/presentation/profile/widgets/custom_chip.dart';
import 'package:newsnews/src/presentation/profile/widgets/custom_stack_item.dart';
import 'package:newsnews/src/presentation/profile/widgets/switch_user_control.dart';
import 'package:newsnews/src/presentation/profile/widgets/user_tab_control.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../di/injector.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationStatus = false;
  bool darkModeStatus = false;
  final userTabControl = [
    {
      "tabName": "Preferences",
      "iconData": PhosphorIcons.sliders,
      "routeName": RouteManager.preferences,
    },
    {
      "tabName": "Abouts",
      "iconData": PhosphorIcons.question,
      "routeName": RouteManager.about,
    },
    {
      "tabName": "Privacy & security",
      "iconData": PhosphorIcons.lockSimple,
      "routeName": RouteManager.privacySecurity,
    },
    {
      "tabName": "Help & support",
      "iconData": PhosphorIcons.headphones,
      "routeName": RouteManager.helpSupport,
    },
    {
      "tabName": "Log out",
      "iconData": PhosphorIcons.signOut,
      // "routeName": "/logout",
    }
  ];
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = injector<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<ProfileCubit>.value(
      value: profileCubit,
      child: Scaffold(
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) async {
            if (state is ProfileSignOutLoading) {
              showLoadingDialog(context);
            } else if (state is ProfileSignOutSuccessfully) {
              Navigator.pushNamedAndRemoveUntil(context, RouteManager.signIn,
                  ModalRoute.withName(RouteManager.signIn));
            }
          },
          child: RefreshIndicator(
            onRefresh: () => profileCubit.getUserInformation(),
            child: SafeArea(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 210.h + 50.h + 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14.w, bottom: 8.h),
                            child: Text(
                              "Interest",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                            child: BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, state) {
                                if (state is LoadUserDataSuccessfully) {
                                  if (state.user.interestAI != null &&
                                      state.user.interestAI!.isNotEmpty) {
                                    return ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.user.interestAI?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return CustomChip(
                                          interest:
                                              state.user.interestAI![index],
                                        );
                                      },
                                    );
                                  } else if (state.user.interestAI != null &&
                                      state.user.interestAI!.isEmpty) {
                                    return const Center(
                                      child: Text(
                                          "Please choose interests for yourself"),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text(
                                          "Please choose interests for yourself"),
                                    );
                                  }
                                } else if (state is LoadUserDataLoading) {
                                  return const Center(
                                    child: Text("Loading!"),
                                  );
                                } else {
                                  return const Center(
                                    child: Text("Can't load your interest"),
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, bottom: 8.h, top: 8.h),
                            child: Text(
                              "User Settings",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
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
                          BlocSelector<ThemeCubit, ThemeState, bool>(
                            selector: (state) => state is DarkTheme,
                            builder: (context, value) {
                              return SwitchUserControl(
                                label: 'Dark Mode',
                                isLast: true,
                                onSwitchActionFunction: (value) => context
                                    .read<ThemeCubit>()
                                    .changeDarkModeStatus(value: value),
                                status: value,
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          for (int i = 0; i < userTabControl.length - 1; i++)
                            UserTabControl(
                              typeBorderRadius: i == 0
                                  ? 0
                                  : (i == userTabControl.length - 1 ? 1 : 2),
                              onTabNameFunction: () => Navigator.pushNamed(
                                context,
                                userTabControl[i]["routeName"] as String,
                              ),
                              tabName: userTabControl[i]["tabName"] as String,
                              iconData:
                                  userTabControl[i]["iconData"] as IconData,
                            ),
                          UserTabControl(
                            typeBorderRadius: 1,
                            onTabNameFunction: () => profileCubit.signOut(),
                            tabName: userTabControl[userTabControl.length - 1]
                                ["tabName"] as String,
                            iconData: userTabControl[userTabControl.length - 1]
                                ["iconData"] as IconData,
                          ),
                          SizedBox(height: 20.h)
                        ],
                      ),
                      Container(
                        height: 210.h,
                        width: size.width,
                        color: Palette.primaryColor,
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            BlocBuilder<ProfileCubit, ProfileState>(
                              // buildWhen: ((previous, current) {
                              //   return previous != current;
                              // }),
                              builder: (context, state) {
                                if (state is LoadUserDataSuccessfully) {
                                  return Row(
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
                                                color:
                                                    Palette.tagInSpecifiedColor,
                                                width: 2.5,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            padding: const EdgeInsets.all(3.5),
                                            child: CircleAvatar(
                                              backgroundImage: Image.network(
                                                state.user.imageUrl ?? "",
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  }
                                                },
                                              ).image,
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 16.sp,
                                            backgroundColor:
                                                Palette.textColorInBlueBGColor,
                                            child: IconButton(
                                              iconSize: 22.sp,
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              icon: const Icon(
                                                  PhosphorIcons.cameraBold),
                                              onPressed: () {},
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state.user.displayName != ""
                                                    ? state.user.displayName!
                                                    : "Your name",
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Palette
                                                      .textColorInBlueBGColor,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.4.w,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: IconButton(
                                                      icon: const Icon(
                                                          PhosphorIcons
                                                              .pencilLine),
                                                      color: Palette
                                                          .textColorInBlueBGColor,
                                                      iconSize: 22.sp,
                                                      constraints:
                                                          const BoxConstraints(),
                                                      onPressed: () async {
                                                        try {
                                                          final value =
                                                              await Navigator
                                                                  .push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => BlocProvider<
                                                                      ProfileCubit>.value(
                                                                  value:
                                                                      profileCubit,
                                                                  child: EditProfileScreen(
                                                                      user: state
                                                                          .user)),
                                                            ),
                                                          );
                                                          if (value) {
                                                            await Future
                                                                .delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                            ).then((value) =>
                                                                profileCubit
                                                                    .getUserInformation());
                                                          }
                                                        } catch (e) {
                                                          log("No value after pop in Edit to Profile");
                                                        }
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            state.user.email ??
                                                "Your email will be here",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Palette
                                                  .textColorInBlueBGColor,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.2.w,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (state is LoadUserDataFail) {
                                  return Center(
                                    child: Column(children: [
                                      const Icon(PhosphorIcons.warningBold,
                                          color: Palette.backgroundBoxColor),
                                      Text(
                                        "Has error!\nPlease scroll down to refresh",
                                        style: TextStyle(
                                            color: Palette.backgroundBoxColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                                  );
                                } else if (state is LoadUserDataLoading) {
                                  return const CircularProgressIndicator(
                                    color: Palette.backgroundBoxColor,
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 210.h - 50.h,
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => profileCubit.signOut(),
                              child: const CustomStackItem(
                                itemName: 'Favorites',
                                icon: PhosphorIcons.heartBold,
                                itemCounter: 100,
                              ),
                            ),
                            const CustomStackItem(
                              itemName: 'Likes',
                              icon: PhosphorIcons.thumbsUpBold,
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
        ),
      ),
    );
  }
}
