// ignore_for_file: use_build_context_synchronously

import 'package:attendance_app/auth/repo/auth_exceptions.dart';
import 'package:attendance_app/auth/repo/repo.dart';
import 'package:attendance_app/utils/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit_state_model.dart';

class AuthCubit extends Cubit<AuthCubitStateModel> {
  AuthCubit() : super(const AuthCubitStateModel());

  FirebaseRepo firebaseRepo = FirebaseRepo();
  final TextEditingController emailControllerSignup = TextEditingController();
  final TextEditingController nameControllerSignup = TextEditingController();
  final TextEditingController passwordControllerSignup =
      TextEditingController();
  final TextEditingController emailControllerLogin = TextEditingController();
  final TextEditingController passwordControllerLogin = TextEditingController();
  final TextEditingController emailControllerForgetPassword =
      TextEditingController();

  Future<void> onSignInButtonClicked(BuildContext context) async {
    emit(state.copyWith(onChanged: true));
    await Future.delayed(const Duration(milliseconds: 500));
    final email = emailControllerSignup.text.trim();
    final password = passwordControllerSignup.text;
    final firebaseUser = FirebaseRepo();
    try {
      await firebaseUser.signUp(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        if (!context.mounted) return;
        showEmailVerificationDialog(
            context,
            'Email verification link is sent to your Email,\n'
            'Once verified try login again!');
        emit(state.copyWith(onChanged: false));
        var studentReference =
            FirebaseFirestore.instance.collection('students');
        studentReference.doc(user.uid + nameControllerSignup.text).set(
          {
            'name': nameControllerSignup.text.trim(),
            'enrolledCourse': '',
            "profilePhoto": '',
            'yearId': []
          },
        );
        var yearReference = FirebaseFirestore.instance.collection('year');
        yearReference
            .doc(user.uid + nameControllerSignup.text + state.year.toString())
            .set(
          {
            'total_present': 0,
            'total_absent': 0,
            'days_off': 0,
            'subjectId': [],
          },
        );
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
    emit(state.copyWith(onChanged: false));
  }

  void onYearClicked(int val) {
    emit(state.copyWith(year: val));
  }

  Future<void> onLoginButtonClicked(BuildContext context) async {
    emit(state.copyWith(onChanged: true));
    // setState(() {
    //   onChanged = true;
    // });
    await Future.delayed(const Duration(milliseconds: 500));
    final email = emailControllerLogin.text.trim();
    final password = passwordControllerLogin.text;
    final firebaseUser = FirebaseRepo();
    try {
      await firebaseUser.logInUser(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        if (!context.mounted) return;

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/homepage/', (route) => false);
      } else if (user != null && user.emailVerified == false) {
        showErrorDialog(context, 'Please verify your Email first!');
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
    emit(state.copyWith(onChanged: false));
  }

  Future<void> onForgetPasswordClicked(BuildContext context) async {
    emit(state.copyWith(onChanged: true));

    await Future.delayed(const Duration(milliseconds: 500));
    final email = emailControllerForgetPassword.text.trim();
    final firebaseUser = FirebaseRepo();
    try {
      await firebaseUser.forgetPassword(email: email);
      if (!context.mounted) return;
      showErrorDialog(context, 'Password reset link is sent to your Email.');
      emit(state.copyWith(onChanged: false));
    } on UserNotFoundAuthException catch (_) {
      showErrorDialog(context, 'User Not Found');
    } on InvalidEmailAuthException catch (_) {
      showErrorDialog(context, 'Invalid Email Address');
    } on GenericAuthException catch (_) {
      showErrorDialog(context, 'Authentication Error');
    }
    emit(state.copyWith(onChanged: false));
  }
}
