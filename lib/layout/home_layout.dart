import 'package:fire_one/screens/login_screen/loginscreen.dart';
import 'package:fire_one/screens/post_screen/post_screen.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/constants/local/shared_pref.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, AddPostScreen());
        }
      },
      builder: (context, state) {

        var cubit = SocialCubit.get(context);
        // cubit.getUserData();
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.bottomIndex]),
            actions: [
              IconButton(
                onPressed: () {
                  CachHelper.clearData();
                },
                icon: const Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    CachHelper.removeData(key: 'uId');
                    navigateAndFinishTo(context, SocialLoginScreen());
                  });
                },
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.bottomIndex,
            items: cubit.items,
          ),
          body: cubit.screens[cubit.bottomIndex],
        );
      },
    );
  }
}
