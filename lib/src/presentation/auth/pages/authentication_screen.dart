import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/helpers/show_loading_dialog.dart';
import 'package:newsnews/src/core/theme/asset_path.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/di/injector.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';
import 'package:newsnews/src/presentation/auth/widgets/sign_in_with_button.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => s1<AuthCubit>(),
      child: Scaffold(
          backgroundColor: Palette.primaryColor,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessful) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouterManager.main,
                  (route) => false,
                );
              } else if (state is AuthLoading) {
                showLoadingDialog(context);
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
          )),
    );
  }
}
