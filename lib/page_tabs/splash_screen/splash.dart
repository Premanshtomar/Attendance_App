import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance_app/custom_widgets/custom_widgets.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../auth/pages/login.dart';
import '../../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return
            // FutureBuilder(
            //   future: cubit.setData(),
            //   builder: (BuildContext context, AsyncSnapshot snapshot) {
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.done:
            //         Future.delayed(Duration(milliseconds: 3000));
            //         return FirebaseAuth.instance.currentUser != null &&
            //                 FirebaseAuth.instance.currentUser!.emailVerified ==
            //                     true
            //             ? const Home()
            //             : const LogInPage();
            //       default:
            //         Future.delayed(Duration(milliseconds: 3000));
            //
            //         return Splash();
            //     }
            //   });

            AnimatedSplashScreen(
          function: cubit.setData,
          animationDuration: const Duration(
            milliseconds: 3000,
          ),
          splashIconSize: 100,
          splash: Row(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16,0,0,0),
                child: Text(
                  'Attendance',
                  textScaleFactor: 2.5,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.height*0.03,),
              SpinKitFoldingCube(
                color: NaturalColors.lightBlack,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     CircleAvatar(
          //       // radius: MediaQuery.of(context).size.height*0.5,
          //       backgroundImage: AssetImage('assets/splash.png'),
          //     ),
          //     Icon(Icons.add),
          //   ],
          // ),
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
    return Scaffold(
      backgroundColor: NaturalColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customImageContainer(context, 'assets/splash.png'),
              SpinKitSpinningLines(
                // duration: Duration(milliseconds: 3000),
                color: NaturalColors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
