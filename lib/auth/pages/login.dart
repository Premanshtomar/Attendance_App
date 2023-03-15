// ignore_for_file: use_build_context_synchronously

import 'package:attendance_app/auth/repo/repo.dart';
import 'package:attendance_app/utils/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../repo/auth_exceptions.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool onChanged = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customImageContainer(context, 'assets/login.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const Text(
              'Hello!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * .90,
              child: Column(
                children: [
                  customTextFieldWidget(
                      'Email', _email, CupertinoIcons.at_circle, false),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  customTextFieldWidget(
                      'Password', _password, CupertinoIcons.lock_circle, true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/reset_pass/', (route) => false);
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(onChanged ? 150 : 10),
                    color: onChanged
                        ? Colors.lightBlueAccent.shade200
                        : Colors.grey.shade200,
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          onChanged = true;
                        });
                        // await Future.delayed(const Duration(milliseconds: 500));
                        final email = _email.text.trim();
                        final password = _password.text;
                        final firebaseUser = FirebaseRepo();
                        try {
                          await firebaseUser.logInUser(
                              email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null && user.emailVerified) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/homepage/', (route) => false);
                          } else if (user != null &&
                              user.emailVerified == false) {
                            showErrorDialog(
                                context, 'Please verify your Email first!');
                          }
                        } on UserNotFoundAuthException catch (_) {
                          showErrorDialog(context, 'User Not Found.');
                        } on WrongPasswordAuthException catch (_) {
                          showErrorDialog(context, 'Wrong Password.');
                        } on InvalidEmailAuthException catch (_) {
                          showErrorDialog(context, 'Invalid Email');
                        } on GenericAuthException catch (_) {
                          showErrorDialog(context, 'Authentication Error.');
                        }
                        setState(() {
                          onChanged = false;
                        });
                      },
                      child: AnimatedContainer(
                        // alignment: Alignment.center,
                        width: onChanged
                            ? MediaQuery.of(context).size.width * 0.12
                            : MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.14,
                        duration: const Duration(milliseconds: 500),
                        child: onChanged
                            ? const Icon(
                                Icons.done,
                                color: Colors.black,
                                size: 50,
                              )
                            : const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textScaleFactor: 3,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Not Registered?Sign-up here->',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.blueGrey),
                  textScaleFactor: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signing/', (route) => false);
                    },
                    child: const Text(
                      'Sign-up!',
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                      textScaleFactor: 1.5,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
