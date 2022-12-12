import 'package:flutter/material.dart';
import 'package:pim/models/courses.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  final Courses data;
  const DetailsScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 4),
      ),
      body: Body(product: data),
    );
  }
}

class ProductDetailsArguments {
  final Courses product;

  ProductDetailsArguments({required this.product});
}
