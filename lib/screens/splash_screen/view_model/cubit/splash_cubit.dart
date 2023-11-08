import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fire_one/layout/home_layout.dart';
import 'package:fire_one/screens/login_screen/loginscreen.dart';
import 'package:fire_one/screens/splash_screen/view_model/cubit/splash_state.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/token_util/token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  void handleSplah(BuildContext context) {
    var duration = const Duration(milliseconds: 3000);
    Timer(duration, () => handleRoute(context));
  }

  handleRoute(BuildContext context) async {
    var tokenFromMemory = await TokenUtil.getTokenFromMemory();
    if (tokenFromMemory != "") {
      Future.delayed(Duration.zero, () {
        navigateAndFinishTo(context, const HomeLayout());
      });
    } else {
      Future.delayed(Duration.zero, () {
        navigateAndFinishTo(context, SocialLoginScreen());
      });
    }
  }
}
