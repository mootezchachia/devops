import 'package:flutter/material.dart';
import 'package:pim/screens/login_screen.dart';
import 'package:pim/screens/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String _route;
  late Future<bool> _session;

  Future<bool> _getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("idUser")) {
      _route = "/navBottem";
    } else {
      _route = "/signin";
    }

    return true;
  }

  @override
  void initState() {
    _session = _getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _session,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (_route == "/signin")
            return LoginScreen();
          else
            return RootApp();
        } else {
          return Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
