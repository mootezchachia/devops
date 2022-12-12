import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pim/models/courses.dart';
import 'package:pim/screens/details_screen.dart';
import 'package:pim/theme/color.dart';
import 'package:pim/widgets/course_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmarked extends StatefulWidget {
  const Bookmarked({Key? key}) : super(key: key);

  @override
  State<Bookmarked> createState() => _BookmarkedState();
}

class _BookmarkedState extends State<Bookmarked> {
  final List<Courses> _courses = [];
  final String _baseUrl = "10.0.2.2:4000";

  late Future<bool> fetchedCourses;
  late SharedPreferences prefs;
  Future<void> initializePreference() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  Future<bool> fetchCourse() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "id": prefs.getString("idUser").toString(),
    };
    http.Response response = await http
        .get(Uri.http(_baseUrl, "/coursePi/getBookmarked"), headers: headers);
    print(response.body);
    List<dynamic> pubFromSever = json.decode(response.body);
    for (int i = 0; i < pubFromSever.length; i++) {
      _courses.add(
        Courses(
          id: pubFromSever[i]["_id"],
          name: pubFromSever[i]["name"],
          description: pubFromSever[i]["description"],
          price: pubFromSever[i]["price"],
          requirement: pubFromSever[i]["requirement"],
          duration: pubFromSever[i]["duration"],
          image: pubFromSever[i]["image"],
        ),
      );
    }
    return true;
  }

  Future<bool> loading() async {
    return false;
  }

  @override
  void initState() {
    fetchedCourses = loading();
    initializePreference().whenComplete(() {
      fetchedCourses = fetchCourse();
    });

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
            "Bookmarked",
            style: TextStyle(color: textColor),
          ),
          elevation: 0,
        ),
        backgroundColor: appBgColor,
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 8, right: 8),
        child: FutureBuilder(
          future: fetchedCourses,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return getFeature();
          },
        ),
      ),
    );
  }

  getFeature() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _courses.length,
      itemBuilder: (context, index) => CourseItem(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                data: _courses[index],
              ),
            ),
          );
        },
        data: _courses[index],
      ),
    );
  }
}
