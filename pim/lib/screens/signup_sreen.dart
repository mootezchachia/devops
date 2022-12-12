import 'package:pim/utils/code_refector.dart';
import 'package:pim/utils/exports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String _email;
  late String _password;
  late String _username;
  final String _baseUrl = "10.0.2.2:4000";
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  bool _value = false;
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
                          txt: "Sign Up",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      customText(
                          txt: "Please sign up to enter in a app.",
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
                            labelText: "Username"),
                        onSaved: (String? value) {
                          _username = value!;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "L'adresse email ne doit pas etre vide";
                          } else if (value.length < 5) {
                            return "Username should be more than 5 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
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
                            return "L'adresse email ne doit pas etre vide";
                          } else if (!RegExp(pattern).hasMatch(value)) {
                            return "L'adresse email est incorrecte";
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
                            labelText: "Mot de passe"),
                        onSaved: (String? value) {
                          _password = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le mot de passe ne doit pas etre vide";
                          } else if (value.length < 5) {
                            return "Le mot de passe doit avoir au moins 5 caractères";
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(height: 100),
                      InkWell(
                        child: SignUpContainer(st: "Sign Up"),
                        onTap: () {
                          if (_keyForm.currentState!.validate()) {
                            _keyForm.currentState!.save();
                            Map<String, dynamic> userData = {
                              "email": _email,
                              "password": _password,
                              "username": _username,
                            };
                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };
                            http
                                .post(Uri.http(_baseUrl, "/users/signup/"),
                                    headers: headers,
                                    body: json.encode(userData))
                                .then(
                              (http.Response response) {
                                if (response.statusCode == 201) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginScreen();
                                      },
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
                              one: "Already have an account ? ", two: "Login"),
                        ),
                        onTap: () {
                          Navigator.pushReplacement<void, void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginScreen(),
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
