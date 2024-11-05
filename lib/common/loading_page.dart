import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Pallete.backgroundColor.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Pallete.blueColor,
          color: Pallete.whiteColor,
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Loader(),
    );
  }
}

