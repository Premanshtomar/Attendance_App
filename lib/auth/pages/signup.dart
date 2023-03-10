// ignore_for_file: use_build_context_synchronously

import 'package:attendance_app/auth/repo/repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/alert_dialog.dart';
import '../repo/auth_exceptions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool onChanged = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ('assets/signup.png'),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const Text(
              'Welcome',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              textScaleFactor: 3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              // padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width * .90,
              // color: Colors.red,
              child: Column(
                children: [
                  TextField(
                    controller: _name,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.at_circle),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.grey,
                      filled: true,
                      label: const Text(
                        'Full Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.at_circle),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.grey,
                      filled: true,
                      label: const Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextField(
                    controller: _password,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.lock_circle),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: Colors.grey,
                      filled: true,
                      label: const Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
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
                        await Future.delayed(const Duration(milliseconds: 500));
                        final email = _email.text.trim();
                        final password = _password.text;
                        final firebaseUser = FirebaseRepo();
                        try {
                          await firebaseUser.signUp(
                              email: email, password: password);
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await user.sendEmailVerification();
                            showEmailVerificationDialog(
                                context,
                                'Email verification link is sent to your Email,\n'
                                'Once verified try login again!');
                            setState(() {
                              onChanged = false;
                            });
                            var reference = FirebaseFirestore.instance.collection(
                                FirebaseAuth.instance.currentUser!.uid);
                            reference.add({
                              'name': _name.text.trim()
                            }).then((value) => print(value.get()));
                          }
                          // Navigator.of(context).pushNamed('/email_verify/');
                        } on WeakPasswordAuthException catch (_) {
                          showErrorDialog(context, 'Password Is Too Weak');
                        } on EmailAlreadyInUseAuthException catch (_) {
                          showErrorDialog(context, 'Email Already In Use.');
                        } on InvalidEmailAuthException catch (_) {
                          showErrorDialog(context, 'Invalid Email');
                        } on GenericAuthException catch (e) {
                          showErrorDialog(context, e.toString());
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
                                  'Sign in',
                                  style: TextStyle(
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
                  'Already Registered?Login here->',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.blueGrey),
                  textScaleFactor: 1,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/logging/', (route) => false);
                    },
                    child: const Text(
                      'Login!',
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