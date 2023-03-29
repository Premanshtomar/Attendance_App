import 'dart:io';

import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/utils/alert_dialog.dart';
import 'package:attendance_app/utils/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  File? _image;
  var user = FirebaseAuth.instance.currentUser;

  Profile({super.key});

  // Future _pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) {
  //       null;
  //     }
  //     File? img = File(image!.path);
  //     setState(() {
  //       _image = img;
  //     });
  //   } on PlatformException catch (e) {
  //     showErrorDialog(context, e.toString());
  //   }
  // }
  Widget yearChangeCheckbox(int yearNo, AppCubit cubit) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          yearNo.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        Checkbox(
          fillColor: MaterialStateColor.resolveWith(
            (states) => NaturalColors.black,
          ),
          activeColor: Colors.black,
          value: yearNo == cubit.state.checkedYear,
          onChanged: (_) {
            cubit.onYearChangedClicked(yearNo);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        var cubit = context.read<AppCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.blue,
                  child: InkWell(
                    onTap: () async {
                      var value = await showImagePickerDialog(context);
                      // if (value != null) {
                      //   _pickImage(
                      //     value == true
                      //         ? ImageSource.gallery
                      //         : ImageSource.camera,
                      //   );
                      // }
                    },
                    child: Center(
                      child: _image == null
                          ? CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.3,
                              backgroundColor: Colors.black45,
                              child: const Text(
                                'No image selected',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.3,
                              backgroundImage: FileImage(_image!),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'Name : ',
                            ),
                            TextWidget(
                              text: state.studentName,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'Email : ',
                            ),
                            TextWidget(
                              text: FirebaseAuth.instance.currentUser!.email
                                  .toString(),
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'Course : ',
                            ),
                            TextWidget(
                              text: state.course,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: 'Year : ',
                            ),
                            TextWidget(
                              text: state.selectedYear.toString(),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BlocBuilder<AppCubit,
                                          AppCubitStateModel>(
                                        builder: (context, state) {
                                          return AlertDialog(
                                            content: Wrap(
                                              children: [
                                                yearChangeCheckbox(1, cubit),
                                                yearChangeCheckbox(2, cubit),
                                                yearChangeCheckbox(3, cubit),
                                                yearChangeCheckbox(4, cubit),
                                                yearChangeCheckbox(5, cubit),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  cubit.onYearCancelClicked();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'No Thanks',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  cubit.onYearSetClicked();
                                                  Navigator.pop(context);
                                                  // print(state.isCheckedYear.toString());
                                                },
                                                child: const Text(
                                                  'Set',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                              },
                              child: const Text("(Change Year)"),
                            ),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: const Icon(Icons.add_circle),
                            // ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              text: '% in Year : ',
                            ),
                            TextWidget(
                              text: '${state.yearPercent}%',
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () async {
                          var shouldLogout = await showLogOutDialog(context);
                          if (shouldLogout) {
                            cubit.onPageChanged(1);
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushNamed('/logging/');
                          }
                        },
                        icon: const Icon(Icons.logout)),
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
