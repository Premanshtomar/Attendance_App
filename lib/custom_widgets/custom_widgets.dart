import 'package:flutter/material.dart';

Widget customTextFieldWidget(String text, TextEditingController controller,
    IconData icon, bool obscure) {
  return TextField(
    obscureText: obscure,
    controller: controller,
    keyboardType:
        obscure == false ? TextInputType.emailAddress : TextInputType.text,
    enableSuggestions: false,
    autocorrect: false,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: text,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      fillColor: Colors.grey,
      filled: true,
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

Widget customImageContainer(BuildContext context, String image) {
  return Container(
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    height: MediaQuery.of(context).size.height * 0.35,
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.topCenter,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(
            (image),
          ),
          fit: BoxFit.cover),
    ),
  );
}

