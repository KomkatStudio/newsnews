import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsnews/src/core/theme/asset_path.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/main/presentation/view/main_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.primaryColor,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessful) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Text(
                      "NewsNews",
                      style: TextStyle(
                        color: Palette.backgroundBoxColor,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    SignInWithButton(
                      logoName: 'Google',
                      logoPath: AssetPath.googleLogo,
                      onPressFunction: () =>
                          context.read<AuthCubit>().signInUsingGoolge(),
                    ),
                    SizedBox(height: 12.h),
                    SignInWithButton(
                      logoName: 'Facebook',
                      logoPath: AssetPath.facebookLogo,
                      onPressFunction: () {},
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class SignInWithButton extends StatelessWidget {
  const SignInWithButton({
    Key? key,
    required this.logoPath,
    required this.logoName,
    required this.onPressFunction,
  }) : super(key: key);

  final String logoPath;
  final String logoName;
  final VoidCallback onPressFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressFunction,
      child: Container(
        height: 55.h,
        width: 100.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Palette.backgroundBoxColor,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox.square(
                  dimension: 28.sp,
                  child: SvgPicture.asset(logoPath),
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Sign in with $logoName",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
