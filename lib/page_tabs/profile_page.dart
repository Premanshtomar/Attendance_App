import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/alert_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;

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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              // color: Colors.blue,
              child: InkWell(
                onTap: () async {
                  showImagePickerDialog(context);
                  _pickImage(
                    await showImagePickerDialog(context)
                        ? ImageSource.gallery
                        : ImageSource.camera,
                  );
                },
                child: Center(
                  child: _image == null
                      ? CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.3,
                          backgroundColor: Colors.black45,
                          child: const Text(
                            'No image selected',
                            style: TextStyle(color: Colors.black, fontSize: 20),
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
                      children: const [
                        TextWidget(
                          text: 'Name : ',
                        ),
                        TextWidget(
                          text: 'Data',
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
                          text: 'Course : ',
                        ),
                        TextWidget(
                          text: 'B.A.M.S',
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.text, this.color})
      : super(key: key);
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}
