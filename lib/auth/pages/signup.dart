import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/auth_bloc/auth_cubit_state_model.dart';
import 'package:attendance_app/custom_widgets/custom_widgets.dart';
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
            (states) => Colors.deepPurple,
          ),
          value: yearNo == cubit.state.year,
          onChanged: (val) {
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
                  height: MediaQuery.of(context).size.height * .02,
                ),
                SizedBox(
                  // padding: const EdgeInsets.all(30),
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .90,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      customTextFieldWidget(
                        text: 'Name',
                        controller: cubit.nameControllerSignup,
                        icon: const Icon(CupertinoIcons.person_alt),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                        text: 'Email',
                        controller: cubit.emailControllerSignup,
                        icon: const Icon(CupertinoIcons.at_circle),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                        text: 'Password',
                        icon: const Icon(CupertinoIcons.lock_circle),
                        obscure: true,
                        controller: cubit.passwordControllerSignup,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
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
                            ? Colors.lightBlueAccent.shade200
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
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.black,
                                    size: 50,
                                  )
                                : const Center(
                                    child: Text(
                                      'Sign in',
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
                      'Already Registered?Login here->',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
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
      },
    );
  }
}
