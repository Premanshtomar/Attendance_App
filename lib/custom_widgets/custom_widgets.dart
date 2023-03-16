import 'package:attendance_app/styles/colors/colors.dart';
import 'package:attendance_app/styles/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

Widget customTextFieldWidget({
  required String text,
  required TextEditingController controller,
  Widget? icon,
  bool? obscure,
  Color? backgroundColor,
}) {
  return TextField(
    obscureText: obscure ?? false,
    controller: controller,
    keyboardType:
        obscure == false ? TextInputType.emailAddress : TextInputType.text,
    enableSuggestions: false,
    autocorrect: false,
    decoration: InputDecoration(
      prefixIcon: icon,
      // hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color:AppColors.primaryAccentColor ),
      ),
      fillColor: backgroundColor ?? NaturalColors.lightGrey,
      filled: true,
      label: Text(
        text,
        style: AppTextStyles.textStyleHeading12,
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
