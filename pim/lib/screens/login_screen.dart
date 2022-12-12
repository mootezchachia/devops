import 'package:pim/screens/root_app.dart';
import 'package:pim/utils/code_refector.dart';
import 'package:pim/utils/exports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _username;
  late String _password;
  bool _value = false;
  final String _baseUrl = "10.0.2.2:4000";
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      customText(
                          txt: "Login Now",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      customText(
                          txt: "Please login to continue using our app.",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          )),
                      const SizedBox(
                        height: 180,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: "Email"),
                        onSaved: (String? value) {
                          _email = value!;
                        },
                        validator: (String? value) {
                          String pattern =
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          if (value == null || value.isEmpty) {
                            return "Email shouldn't be empty";
                          } else if (!RegExp(pattern).hasMatch(value)) {
                            return "Email is wrong";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            labelText: "Password"),
                        onSaved: (String? value) {
                          _password = value!;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Password shouldn't be empty";
                          } else if (value.length < 5) {
                            return "Password should have at least 5 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 100),
                      InkWell(
                        child: SignUpContainer(st: "LogIn"),
                        onTap: () {
                          if (_keyForm.currentState!.validate()) {
                            _keyForm.currentState!.save();
                            Map<String, dynamic> userData = {
                              "email": _email,
                              "password": _password,
                            };
                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };
                            http
                                .post(Uri.http(_baseUrl, "/users/login/"),
                                    headers: headers,
                                    body: json.encode(userData))
                                .then(
                              (http.Response response) async {
                                if (response.statusCode == 201) {
                                  Map<String, dynamic> userFromServer =
                                      json.decode(response.body);
                                  print(userFromServer);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  prefs.setString(
                                      "email", userFromServer["email"]);
                                  prefs.setString(
                                      "idUser", userFromServer["_id"]);
                                  prefs.setString(
                                      "username", userFromServer["username"]);
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          RootApp(),
                                    ),
                                  );
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
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        child: RichText(
                          text: RichTextSpan(
                              one: "Don’t have an account ? ", two: "Sign Up"),
                        ),
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SignupScreen(),
                            ),
                          );
                        },
                      ),
                      //Text("data"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
