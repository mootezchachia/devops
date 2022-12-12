import 'package:flutter/material.dart';
import 'package:pim/screens/login_screen.dart';
import 'package:pim/screens/root_app.dart';
import 'package:pim/screens/splach_screen.dart';
import 'package:pim/theme/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Course App',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: const SplashScreen(),
    );
  }
}
