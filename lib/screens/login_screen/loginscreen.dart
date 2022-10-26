import 'package:fire_one/layout/home_layout.dart';
import 'package:fire_one/screens/login_screen/social_app_login_cubit/cubit.dart';
import 'package:fire_one/screens/login_screen/social_app_login_cubit/states.dart';
import 'package:fire_one/screens/register_screen/register.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/constants/local/shared_pref.dart';
import 'package:fire_one/shared/constants/local/vars.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          bool pass = SocialLoginCubit.get(context).isShown;

          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(fontSize: 25, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          controller: emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'EmailAddress',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        /* password field*/ TextFormField(
                          onFieldSubmitted: (String value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                          },
                          controller: passwordController,
                          obscureText: pass,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialLoginCubit.get(context).showPass();
                              },
                              icon: Icon(cubit.suffixicon),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 40.0,
                          color: Colors.blue,
                          child: state is! SocialLoginScreenLoadingState
                              ? TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.deepOrange,
                                )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SocialRegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is SocialLoginScreenErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginScreenSuccessState) {
            showToast(text: state.message, state: ToastStates.SUCCESS);
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              // print(value.user);

              uId = value.user!.uid;
              CachHelper.saveData(key: 'uId', value: uId);
              navigateAndFinishTo(context, const HomeLayout());
              SocialCubit.get(context).getUserData();
            });
          }
        },
      ),
    );
  }
}
