import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/pages/forget_password.dart';
import 'package:attendance_app/auth/pages/login.dart';
import 'package:attendance_app/auth/pages/signup.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/screens/home.dart';
import 'package:attendance_app/page_tabs/splash_screen/mini_splash.dart';
import 'package:attendance_app/page_tabs/splash_screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialAppWithTheme());
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeChanger>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/homepage/': (context) => const Home(),
            '/logging/': (context) => const LogInPage(),
            '/signing/': (context) => const SignUpPage(),
            '/reset_pass/': (context) => const ForgetPassword(),
            '/mini_splash/':(context)=>const MiniSplash(),
          },
          theme: ThemeData(
              primarySwatch: Colors.grey,
              brightness: Brightness.light),
          home: const SplashScreen()),
    );
  }
}
