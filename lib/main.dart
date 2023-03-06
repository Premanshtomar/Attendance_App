
import 'package:attendance_app/auth/pages/login.dart';
import 'package:attendance_app/page_tabs/tabs_map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homepage/': (context) => const Home(),
        '/logging/': (context) => const LogInPage(),
        '/signing/': (context) => const SignUpPage(),
        '/reset_pass/': (context) => const ForgetPassword(),
      },
      theme: ThemeData(brightness: Brightness.light),
      home: const Home(),
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
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(pageTabs[_pageIndex]['title'],
            style: const TextStyle(fontWeight: FontWeight.w700,
              color: Colors.black,fontStyle: FontStyle.italic
            ),),
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height*0.07,
          color: Colors.black45,
          backgroundColor:Colors.white,
          // pageTabs[_pageIndex]['navigationBarColour'],
          index: _pageIndex,
          onTap: (index) {
            _pageController.animateToPage(
                index, duration: const Duration(microseconds: 400),
                curve: Curves.easeIn);
          },
          items: const [
            Icon(Icons.person_rounded,color: Colors.white,),
            Icon(Icons.notes,color: Colors.white,),
            Icon(Icons.add_reaction_sharp,color: Colors.white,),
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
