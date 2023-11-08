import 'package:fire_one/screens/splash_screen/view/splash_screen.dart';
import 'package:fire_one/screens/splash_screen/view_model/cubit/splash_cubit.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/constants/local/shared_pref.dart';
import 'package:fire_one/shared/constants/local/vars.dart';
import 'package:fire_one/shared/token_util/token_util.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  showToast(text: 'Handling a background message', state: ToastStates.SUCCESS);
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  await CachHelper.init();
  TokenUtil.loadTokenToMemory();
  uId = await TokenUtil.getTokenFromMemory();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => SocialCubit()),
        BlocProvider(create: (context) => SplashCubit()),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
