import 'package:demo/app/modules/auth/presenter/components/sign_up/sign_up_body.dart';
import 'package:demo/core/common/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          body: SignUpBody(
            emailCtrl: emailCtrl,
            passwordCtrl: passwordCtrl,
          ),
          bottomSheet: !isKeyboardVisible ? const Footer() : null,
        );
      },
    );
  }
}
