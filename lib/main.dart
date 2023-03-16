// ignore_for_file: unrelated_type_equality_checks

import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/pages/login.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/tabs_map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/pages/forget_password.dart';
import 'auth/pages/signup.dart';

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
        },
        theme: ThemeData(
            // primarySwatch: Brightness.light==true?Colors.deepPurple:Colors.red,
            brightness: Brightness.light),
        home: FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified == true
            ? const Home()
            : const LogInPage(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex = 0;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              Brightness.light == true ? Colors.white : Colors.black45,
          title: Center(
            child: Text(
              pageTabs[_pageIndex]['title'],
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  // color: Colors.black,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.black45,
          backgroundColor: Colors.transparent,
          // pageTabs[_pageIndex]['navigationBarColour'],
          index: 1,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(microseconds: 400),
                curve: Curves.easeIn);
          },
          items: const [
            Icon(
              Icons.notes,
              color: Colors.white,
            ),
            Icon(
              Icons.add_reaction_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.person_rounded,
              color: Colors.white,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
          children: [
            pageTabs[0]['pageName'],
            pageTabs[1]['pageName'],
            pageTabs[2]['pageName'],
          ],
        ),
      ),
    );
  }
}
