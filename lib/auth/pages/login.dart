import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/auth_bloc/auth_cubit_state_model.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/styles/text_styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../custom_widgets/custom_widgets.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

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
                        text: 'Email',
                        controller: cubit.emailControllerLogin,
                        icon: const Icon(CupertinoIcons.at_circle),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      customTextFieldWidget(
                        text: 'Password',
                        controller: cubit.passwordControllerLogin,
                        icon: const Icon(CupertinoIcons.lock_circle),
                        obscure: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/reset_pass/', (route) => false);
                            },
                            child: Text('Forget Password?',
                                style: AppTextStyles.textStyleHeading16),
                          ),
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(
                          state.onChanged ? 150 : 10,
                        ),
                        color: state.onChanged
                            ? AppColors.primaryAccentColor
                            : Colors.grey.shade200,
                        child: InkWell(
                          onTap: () async {
                            cubit.onLoginButtonClicked(context);
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
                                : Center(
                                    child: Text(
                                      'Login',
                                      style: AppTextStyles.textStyleHeading14,
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
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
                      textScaleFactor: 1,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/signing/', (route) => false);
                      },
                      child: Text(
                        'Sign-up!',
                        style: AppTextStyles.textStyleHeading20,
                        // textScaleFactor: 1.5,
                      ),
                    ),
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
