// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:attendance_app/page_tabs/app_bloc/app_cubit.dart';
import 'package:attendance_app/page_tabs/app_bloc/app_cubit_state_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/alert_dialog.dart';
import '../utils/text_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  var user = FirebaseAuth.instance.currentUser;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        null;
      }
      File? img = File(image!.path);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStateModel>(
      builder: (context, state) {
        // var cubit = context.read<AppCubit>();
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
                      if (value != null) {
                        _pickImage(
                          value == true
                              ? ImageSource.gallery
                              : ImageSource.camera,
                        );
                      }
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              text: 'Course : ',
                            ),
                            TextWidget(
                              text:state.course,
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
                          children: const [
                            TextWidget(
                              text: '% in Month : ',
                            ),
                            TextWidget(
                              text: 'Data',
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            TextWidget(
                              text: '% in Year : ',
                            ),
                            TextWidget(
                              text: 'Data',
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
