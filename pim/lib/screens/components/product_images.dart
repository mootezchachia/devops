import 'package:flutter/material.dart';
import 'package:pim/models/courses.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Courses product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Hero(
            tag: widget.product.id.toString(),
            child: Image.network(
              "http://10.0.2.2:4000/" +
                  widget.product.image.replaceAll("uploads\\", "/"),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
      ],
    );
  }
}
