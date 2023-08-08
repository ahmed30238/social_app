import 'package:fire_one/screens/login_screen/social_app_login_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isShown = true;

  IconData suffixicon = Icons.remove_red_eye_outlined;

  void showPass() {
    isShown = !isShown;

    suffixicon =
        isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;

    emit(ShowPassState());
  }

  void userData({
    required String email,
    required String password,
    // required String message,
  }) {
    emit(SocialLoginScreenLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(
        SocialLoginScreenSuccessState(
          value.user!.uid,
          value.user?.displayName ?? "",
        ),
      );
    }).catchError((error) {
      emit(SocialLoginScreenErrorState(error.toString()));
    });
  }
}
