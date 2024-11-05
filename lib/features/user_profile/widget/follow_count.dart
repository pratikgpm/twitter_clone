import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class FollowCount extends StatelessWidget {
  final int count;
  final String text;

  const FollowCount({super.key, required this.count, required this.text});

  @override
  Widget build(BuildContext context) {
    const double fontSize = 18.0;
    return Row(
      children: [
        Text(
          '$count',
          style: const TextStyle(
              color: Pallete.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Pallete.greyColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize),
        ),
      ],
    );
  }
}
