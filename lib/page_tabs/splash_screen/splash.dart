import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance_app/auth/pages/login.dart';
import 'package:attendance_app/custom_widgets/custom_widgets.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        return AnimatedSplashScreen(
          function: context.read<AppCubit>().setData,
          animationDuration: const Duration(
            milliseconds: 3000,
          ),
          splashTransition: SplashTransition.fadeTransition,
          splash: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                // radius: MediaQuery.of(context).size.height*0.5,
                backgroundImage: AssetImage('assets/splash.png'),
              ),
              Icon(Icons.add),
            ],
          ),
          nextScreen: FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified == true
              ? const Home()
              : const LogInPage(),
        );
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customImageContainer(context, 'assets/splash.png'),
        Text('data'),
      ],
    );
  }
}
