import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pim/models/courses.dart';
import 'package:pim/screens/root_app.dart';
import 'package:pim/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Courses product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final String _baseUrl = "10.0.2.2:4000";

  late SharedPreferences prefs;

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializePreference().whenComplete(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            widget.product.name,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  "Price : ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  widget.product.price.toString() + " dt",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Duration: ",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  widget.product.duration.toString() + " Hours",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "Description",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            "Requirements",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.requirement,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomButton(
            onPressed: () async {
              Map<String, dynamic> userData = {
                "id": widget.product.id,
                "userId": prefs.getString("idUser"),
              };
              Map<String, String> headers = {
                "Content-Type": "application/json; charset=UTF-8"
              };
              http
                  .put(Uri.http(_baseUrl, "/coursePi/addBookmarked"),
                      headers: headers, body: json.encode(userData))
                  .then(
                (http.Response response) async {
                  if (response.statusCode == 201) {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => RootApp(),
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
            },
            text: "Add to Bookmarks",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomButton(
            onPressed: () async {
              Map<String, dynamic> userData = {
                "id": widget.product.id,
                "userId": prefs.getString("idUser"),
              };
              Map<String, String> headers = {
                "Content-Type": "application/json; charset=UTF-8"
              };
              http
                  .put(Uri.http(_baseUrl, "/coursePi/addParticipated"),
                      headers: headers, body: json.encode(userData))
                  .then(
                (http.Response response) async {
                  if (response.statusCode == 201) {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => RootApp(),
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
            },
            text: "Participate",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
