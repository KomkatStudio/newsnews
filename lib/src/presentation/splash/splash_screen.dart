import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:newsnews/src/core/config/router.dart';
import 'package:newsnews/src/core/helpers/show_snackbar_impl.dart';
import 'package:newsnews/src/core/theme/palette.dart';
import 'package:newsnews/src/presentation/auth/cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessful) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteManager.main,
              (route) => false,
            );
            showSnackbarImpl(context,
                message: "Signed in with your Google: " + state.email);
          } else if (state is NoAuth) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteManager.signIn,
              (route) => false,
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/lottie/splash.json",
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController
                    ..duration = composition.duration
                    ..forward().whenComplete(
                      () => context.read<AuthCubit>().checkHasCurrentUser(),
                    );
                },
                width: 200.w,
              ),
              SizedBox(
                height: 30.h,
              ),
              BlocSelector<AuthCubit, AuthState, bool>(
                selector: (state) {
                  return state is AuthLoading;
                },
                builder: (context, isLoading) {
                  return Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Palette.backgroundInDetailBoxColor,
                          )
                        : SizedBox(
                            height: 20.h,
                          ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
