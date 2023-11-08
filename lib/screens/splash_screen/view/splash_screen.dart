import 'package:fire_one/screens/splash_screen/view_model/cubit/splash_cubit.dart';
import 'package:fire_one/screens/splash_screen/view_model/cubit/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashCubit.get(context).handleSplah(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Icon(
              Icons.home,
              color: Colors.orange,
              size: 33,
            ),
          ),
        );
      },
    );
  }
}
