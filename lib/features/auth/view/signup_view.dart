import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import '../../../theme/pallete.dart';
import '../widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).SignUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: Stack(
        children: [
          isLoading ? const Loader() : Container(
          ) ,
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AuthField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AuthField(controller: passwordController, hintText: 'Password'),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmallButton(
                      onTap: onSignUp,
                      label: "Done",
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have an account ?",
                          style: const TextStyle(
                              color: Pallete.whiteColor, fontSize: 16),
                          children: [
                            TextSpan(
                                text: " Login",
                                style: const TextStyle(
                                    color: Pallete.blueColor, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      LoginView.route(),
                                    );
                                  }),
                          ])),
                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}
