import 'package:attendance_app/auth/auth_bloc/auth_cubit.dart';
import 'package:attendance_app/auth/auth_bloc/auth_cubit_state_model.dart';
import 'package:attendance_app/custom_widgets/custom_widgets.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitStateModel>(
      builder: (context, state) {
        AuthCubit cubit = context.read<AuthCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customImageContainer(context, 'assets/forget.png'),
                const Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  textScaleFactor: 2,
                ),
                const Text(
                  "Don't worry it happens!",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Text(
                  'Enter your Email so we can help you!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  textScaleFactor: 2.75,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      customTextFieldWidget(
                        text: 'Email',
                        controller: cubit.emailControllerForgetPassword,
                        icon:  Icon(CupertinoIcons.at_circle,color: NaturalColors.lightBlack,),
                        obscure: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(state.onChanged ? 150 : 10),
                        color: state.onChanged
                            ? NaturalColors.black
                            : Colors.grey.shade200,
                        child: InkWell(
                          onTap: () async {
                            cubit.onForgetPasswordClicked(context);
                          },
                          child: AnimatedContainer(
                            // alignment: Alignment.center,
                            width: state.onChanged
                                ? MediaQuery.of(context).size.width * 0.12
                                : MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.13,
                            duration: const Duration(milliseconds: 500),
                            child: state.onChanged
                                ? Icon(
                                    Icons.done,
                                    color: NaturalColors.white,
                                    size: 50,
                                  )
                                : Center(
                                    child: Text(
                                      'Send link',
                                      style: TextStyle(
                                        color: TextColors.accentText,
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
                      'Click here to Login->',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: TextColors.accentText,
                      ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
