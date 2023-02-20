import "package:athleticarsenal/constants/global_Variables.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

class Stars extends StatelessWidget {
  final double rating;
  Stars({Key? key, required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: 18,
      // _ used because no need the values
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: GlobalVariables.primaryColor,
      ),
    );
  }
}
