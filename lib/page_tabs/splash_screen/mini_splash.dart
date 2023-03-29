import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/page_tabs/screens/home.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MiniSplash extends StatelessWidget {
  const MiniSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        context.read<AppCubit>().setData();
        return Scaffold(
          body: Center(
            child: AnimatedSplashScreen(
              animationDuration: const Duration(milliseconds: 3000),
              splash: SpinKitFoldingCube(
                color: NaturalColors.lightBlack,
              ),
              nextScreen: const Home(),
            ),
          ),
        );
      },
    );
  }
}
