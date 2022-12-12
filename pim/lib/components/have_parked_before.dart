/*import 'package:flutter/material.dart';
import 'package:vip/constants.dart';

class HaveParkedBefore extends StatelessWidget {
  final bool addCar;
  final VoidCallback press;
  const HaveParkedBefore({
    required Key key,
    this.addCar = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          addCar ? "Don’t have parked bfore ? " : "Already have Parked ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            addCar ? "Skip" : "Register My Vehicule",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
*/
