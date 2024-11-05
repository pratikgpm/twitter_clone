import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/tweet/views/hashtag_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HashtagText extends StatelessWidget {
  final String text;

  const HashtagText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpan = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textSpan.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Pallete.blueColor),
          recognizer: TapGestureRecognizer()..onTap=(){
              Navigator.push(context, HashtagView.rout(element));
        }
        )
        );
      } else if (element.startsWith('www.') || element.startsWith('http://')|| element.startsWith('https://')) {
        textSpan.add(TextSpan(
            text: '$element ',
            style: const TextStyle(fontSize: 16, color: Pallete.blueColor)));
      } else {
        textSpan
            .add(TextSpan(text: "$element ", style: const TextStyle(fontSize: 16)));
      }
    });
    return RichText(text: TextSpan(children: textSpan));
  }
}
