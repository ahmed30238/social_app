import 'package:fire_one/layout/home_layout.dart';
import 'package:fire_one/screens/login_screen/loginscreen.dart';
import 'package:fire_one/screens/register_screen/social_app_register_cubit/cubit.dart';
import 'package:fire_one/screens/register_screen/social_app_register_cubit/states.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserScreenSuccessState) {
            SocialCubit.get(context).getUserData();
            navigateAndFinishTo(
              context,
              const HomeLayout(),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);

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
                          'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Register now to browse our hot offers',
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
                            return null;
                          },
                          controller: nameController,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                            return null;
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
                        defaultTextFormField(
                          controller: phoneController,
                          text: 'Phone',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                            return null;
                          },
                          prefix: Icons.phone,
                          isPass: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'too short';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: cubit.isShown,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialRegisterCubit.get(context).showPass();
                              },
                              icon: Icon(
                                cubit.isShown
                                    ? Icons.visibility
                                    : Icons.visibility_off_sharp,
                              ),
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
                          child: state is! SocialRegisterScreenLoadingState
                              ? TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userData(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                      // CachHelper.saveData(
                                      //     key: 'uId', value: uId);
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : const Center(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SocialLoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login Now',
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
      ),
    );
  }
}
