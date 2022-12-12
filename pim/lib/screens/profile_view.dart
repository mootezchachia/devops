import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pim/screens/login_screen.dart';
import 'package:pim/theme/color.dart';
import 'package:pim/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  late String _username;
  final String _baseUrl = "10.0.2.2:4000";
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    //getSharedPrefs();
    initializePreference().whenComplete(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBgColor,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(color: textColor),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _keyForm,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/img_avatar.png'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    initialValue: prefs.getString("username") ?? "wait",
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Username"),
                    onSaved: (String? value) {
                      _username = value!;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "The Username should not be empty";
                      } else if (value.length < 5) {
                        return "The Username should have at least 5 chars";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    prefs.getString("email") ?? "wait",
                    textScaleFactor: 1.5,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            _keyForm.currentState!.save();
                            print("aaaaaaaaaaaaaaaaaaaa" + _username);
                            Map<String, dynamic> userData = {
                              "id": prefs.getString("idUser"),
                              "username": _username,
                            };
                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };
                            http
                                .post(Uri.http(_baseUrl, "/users/update/"),
                                    headers: headers,
                                    body: json.encode(userData))
                                .then(
                              (http.Response response) async {
                                if (response.statusCode == 200) {
                                  // prefs.setString("username", _username);
                                  prefs.setString("username", _username);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text("Information"),
                                        content: Text(
                                            "Une erreur s'est produite, réessayer plus tard !"),
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                        text: "Edit Profile",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.clear();
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginScreen(),
                            ),
                          );
                        },
                        text: "Logout",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
