import 'package:flutter/material.dart';
import 'package:pim/theme/color.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
      {Key? key,
      this.hint = "",
      this.prefix,
      this.suffix,
      this.controller,
      this.readOnly = false})
      : super(key: key);
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 3),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        border: Border.all(color: textBoxColor),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}
