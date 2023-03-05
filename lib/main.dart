import 'package:attendance_app/auth/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth/pages/forget_password.dart';
import 'auth/pages/signup.dart';

void main()async{

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark

  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialAppWithTheme());
}


class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          '/homepage/': (context) => const Home(),
          '/logging/': (context) => const LogInPage(),
          '/signing/': (context) => const SignUpPage(),
          '/reset_pass/': (context) => const ForgetPassword(),
        },
      theme: ThemeData(brightness: Brightness.light),
      home: const LogInPage(),
    );
  }
}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: const Center(child: Text('hello'),),
    );
  }
}
