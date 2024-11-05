import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/theme/pallete.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: Pallete.whiteColor,
  ));
}

String getNameFromEmail(String email) {
  //pratik@gmail.com
  // List = ['pratik','@gmail.com']
  return email.split("@")[0];
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final img in imageFiles) {
      images.add(File(img.path));
    }
  }
  return images;
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickImage(source: ImageSource.gallery);
  if (imageFiles != null) {
    return File(imageFiles.path);
  }
  return null;
}

InputDecoration inputDecoration({required String hintText}) {
  return InputDecoration(
      hintText: hintText,
      fillColor: Pallete.whiteColor.withOpacity(0.05),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Pallete.backgroundColor),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Pallete.backgroundColor)));
}
