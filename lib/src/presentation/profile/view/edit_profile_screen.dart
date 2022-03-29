import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/domain/entities/user/user_entity.dart';
import 'package:newsnews/src/presentation/profile/cubit/profile_cubit.dart';
import 'package:newsnews/src/widgets/custom_category_choice_chip.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController displayNameController;

  final categoryList = [
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
    final state = context.read<ProfileCubit>().state;
    choseCategoryList = List.filled(categoryList.length, false);
    if (state is LoadUserDataSuccessfully) {
      displayNameController =
          TextEditingController(text: state.user.displayName);
      if (state.user.interest != null) {
        for (var interest in state.user.interest!) {
          choseCategoryList[categoryList.indexOf(interest)] = true;
        }
      }
    }
    super.initState();
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Center(
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
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
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
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextField(
                  controller: displayNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Input your display name",
                    contentPadding: EdgeInsets.only(left: 10.w),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              const Text("Interest"),
              SizedBox(height: 8.h),
              Wrap(
                children: categoryList
                    .map(
                      (category) => CustomCategoryChoiceChip(
                        category: category,
                        choiceStatus:
                            choseCategoryList[categoryList.indexOf(category)],
                        onSelectCategoryFunction: (value) {
                          setState(() {
                            choseCategoryList[categoryList.indexOf(category)] =
                                value;
                          });
                        },
                        sideBorderIsPrimaryColor: false,
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12.r),
                child: Ink(
                  height: 50.h,
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Palette.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Update ",
                      style: TextStyle(
                        color: Palette.backgroundBoxColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
