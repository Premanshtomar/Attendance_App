import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/auth_bloc/auth_cubit_state_model.dart';
import 'package:attendance_app/custom_widgets/custom_widgets.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Widget yearCheckbox(int yearNo, AuthCubit cubit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          fillColor: MaterialStateColor.resolveWith(
            (states) => NaturalColors.black,
          ),
          value: yearNo == cubit.state.year,
          onChanged: (_) {
            cubit.onYearClicked(yearNo);
          },
        ),
        Text(
          yearNo.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AuthCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customImageContainer(context, 'assets/signup.png'),
                SizedBox(
                  // padding: const EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height * .52,
                  width: MediaQuery.of(context).size.width * .90,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      customTextFieldWidget(
                        text: 'Name',
                        hint: 'Full Name',
                        controller: cubit.nameControllerSignup,
                        icon: Icon(
                          CupertinoIcons.person_alt,
                          color: NaturalColors.lightBlack,
                        ),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                        text: 'Email',
                        hint: 'example@xyz.com',
                        controller: cubit.emailControllerSignup,
                        icon: Icon(
                          CupertinoIcons.at_circle,
                          color: NaturalColors.lightBlack,
                        ),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                        text: 'Password',
                        icon: Icon(
                          CupertinoIcons.lock_circle,
                          color: NaturalColors.lightBlack,
                        ),
                        obscure: true,
                        controller: cubit.passwordControllerSignup,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                          text: 'Course Enrolled',
                          controller: cubit.courseFieldController,
                          icon: Icon(
                            Icons.bookmark_added_sharp,
                            color: NaturalColors.lightBlack,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      const Text(
                        'In which year are you in?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Wrap(
                        children: [
                          yearCheckbox(1, cubit),
                          yearCheckbox(2, cubit),
                          yearCheckbox(3, cubit),
                          yearCheckbox(4, cubit),
                          yearCheckbox(5, cubit),
                        ],
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(state.onChanged ? 150 : 10),
                        color: state.onChanged
                            ? NaturalColors.black
                            : Colors.grey.shade200,
                        child: InkWell(
                          onTap: () async {
                            await cubit.onSignInButtonClicked(context);
                          },
                          child: AnimatedContainer(
                            // alignment: Alignment.center,
                            width: state.onChanged
                                ? MediaQuery.of(context).size.width * 0.12
                                : MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.14,
                            duration: const Duration(milliseconds: 500),
                            child: state.onChanged
                                ? Icon(
                                    Icons.done,
                                    color: NaturalColors.white,
                                    size: 50,
                                  )
                                : Center(
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                        color: NaturalColors.black,
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
                    Text(
                      'Already Registered?Login here->',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: NaturalColors.black),
                      textScaleFactor: 1,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/logging/', (route) => false);
                        },
                        child: Text(
                          'Login!',
                          style: TextStyle(
                            color: TextColors.blueGrey,
                          ),
                          textScaleFactor: 1.5,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
