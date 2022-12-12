import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:pim/models/courses.dart';
import 'package:pim/theme/color.dart';
import 'package:pim/widgets/custom_button.dart';

import 'custom_image.dart';

class CourseItem extends StatelessWidget {
  CourseItem(
      {Key? key,
      required this.data,
      this.width = 280,
      this.height = 280,
      this.onTap})
      : super(key: key);
  final Courses data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;
  late String? _reclamation;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final String _baseUrl = "10.0.2.2:3000";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.network(
                "http://10.0.2.2:4000/" +
                    data.image.replaceAll("uploads\\", "/"),
                width: width * 1.4,
                height: height * 0.6,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Text(
                data.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 22,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }

  getAttribute(IconData icon, Color color, String info) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          info,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: labelColor, fontSize: 13),
        ),
      ],
    );
  }
}
