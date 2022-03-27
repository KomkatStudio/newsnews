import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Edit Profile"),
        titleTextStyle: TextStyle(
          fontSize: 22.sp,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<ProfileCubit, ProfileState, UserEntity?>(
              selector: (state) =>
                  state is LoadUserDataSuccessfully ? state.user : null,
              builder: (context, user) {
                return Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Palette.primaryColor,
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(top: 32.h),
                        padding: const EdgeInsets.all(3.5),
                        child: CircleAvatar(
                          backgroundImage: Image.network(
                            user!.imageUrl!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, child, err) {
                              return Icon(
                                PhosphorIcons.warning,
                                color: Palette.primaryColor,
                              );
                            },
                          ).image,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Palette.shadowColor.withOpacity(0.1),
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 18.sp,
                          backgroundColor: Palette.textColorInBlueBGColor,
                          child: IconButton(
                            iconSize: 24.sp,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(PhosphorIcons.cameraBold),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            const Text("Display name"),
            Container(
              height: 50.h,
              decoration: BoxDecoration(border: Border.all()),
            )
          ],
        ),
      ),
    );
  }
}
