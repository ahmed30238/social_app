import 'package:fire_one/layout/home_layout.dart';
import 'package:fire_one/observer/bserver.dart';
import 'package:fire_one/screens/login_screen/loginscreen.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/constants/local/shared_pref.dart';
import 'package:fire_one/shared/constants/local/vars.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(text: 'Handling a background message', state: ToastStates.SUCCESS);
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);

  FirebaseMessaging.onMessage.listen((event) {
    // print(event.data.toString());
    // print('on message');
    showToast(
      text: 'onMessage',
      state: ToastStates.SUCCESS,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // print(event.data.toString());
    // print('on message opened app');
    showToast(
      text: 'onMessageOpenedApp',
      state: ToastStates.SUCCESS,
    );
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  BlocOverrides.runZoned(
    () async {
      await CachHelper.init();

      uId = CachHelper.getData(key: 'uId', value: uId ?? "");
      Widget widget;
      print('user is $user');
      if (user != null) {
        uId = user!.uid;
        widget = const HomeLayout();
      } else {
        uId = '';
        widget = SocialLoginScreen();
      }
      print(uId);

// print(uId);
      runApp(
        MyApp(
          startWidget: widget,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()
        // ..getUserData()
        // ..getPosts(),
        ,
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
