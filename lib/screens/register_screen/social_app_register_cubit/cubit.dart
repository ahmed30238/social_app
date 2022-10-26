import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_one/models/social_model.dart';
import 'package:fire_one/screens/register_screen/social_app_register_cubit/states.dart';
import 'package:fire_one/shared/constants/local/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  bool isShown = true;

  IconData suffixicon = Icons.remove_red_eye_outlined;

  void showPass() {
    isShown = !isShown;

    suffixicon =
        isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;

    emit(ShowRegisterPassState());
  }
  void userData({
    required String email,
    required String password,
    required String phone,
    required String name,
    bool isVerified = false,
  }) {
    emit(SocialRegisterScreenLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        password: password,
        email: email,
        uId: value.user!.uid,
        phone: phone,
        name: name,
      );
      emit(SocialRegisterScreenSuccessState());
    }).catchError((error) {
      emit(SocialRegisterScreenErrorState(error.toString()));
      print(error.toString());
    });
  }

  void userCreate({
    required String email,
    required String uId,
    required String phone,
    required String password,
    required String name,
    String? cover,
    String? image,
    String? bio,
    bool isVerified = false,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      uId: uId,
      name: name,
      phone: phone,
      password: password,
      bio: 'write your bio...',
      image:
          'https://student.valuxapps.com/storage/uploads/banners/1641000140NnSq9.black-friday-cyber-monday-sales.jpg',
      cover:
          'https://student.valuxapps.com/storage/uploads/banners/1641000140NnSq9.black-friday-cyber-monday-sales.jpg',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(SocialCreateUserScreenSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserScreenErrorState(error));
    });
  }

  void updateDatainDatabase({
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateUserLoadingState());
    SocialUserModel userModel = SocialUserModel(
      bio: bio,
      image: image,
      cover: cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(
          userModel.toMap(),
        )
        .then(
          (value) {},
        )
        .catchError(
      (error) {
        emit(SocialUpdateUserErrorState());
        print(error.toString());
      },
    );
  }
}
