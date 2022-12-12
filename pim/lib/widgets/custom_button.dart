import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 62,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF333333),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        elevation: 5.0,
        textStyle: const TextStyle(fontSize: 18),
      ).copyWith(
        minimumSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width, height)),
      ),
    );
  }
}
