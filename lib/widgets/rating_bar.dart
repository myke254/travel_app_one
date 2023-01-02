
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RWidget extends StatelessWidget {
  const RWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
     itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.orange,
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,);
  }
}
