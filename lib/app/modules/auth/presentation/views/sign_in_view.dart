import 'package:demo/app/modules/auth/presentation/components/sign_in/sign_in_body.dart';
import 'package:demo/core/common/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          body: const SignInBody(),
          bottomSheet: !isKeyboardVisible ? const Footer() : null,
        );
      },
    );
  }
}
