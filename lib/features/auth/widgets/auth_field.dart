import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField({super.key, required this.controller, required this.hintText});



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
        contentPadding: const EdgeInsets.all(22),

          enabledBorder: OutlineInputBorder(              //Enable Border
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
          color: Pallete.greyColor)
        ),

          focusedBorder: OutlineInputBorder(             //Focus Border
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 3,
                  color: Pallete.blueColor)
          )
      ),
    );
  }
}
