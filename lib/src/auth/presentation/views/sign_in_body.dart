import 'package:education_app/core/common/widgets/simple_text.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:education_app/src/auth/presentation/widgets/sign_in_row.dart';
import 'package:education_app/src/auth/presentation/widgets/top_animation.dart';
import 'package:education_app/src/auth/presentation/widgets/top_title.dart';
import 'package:flutter/material.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const TopAnimation(
              animation: 'login',
              maxHeight: 350,
              minHeight: 350,
            ),
            const TopTitle(title: 'Easy to learn, discover more skills.'),
            const SimpleText(
              mgLeft: 13,
              mgRight: 13,
              text: 'Sign in to your account.',
              fontSize: 16,
              alignment: Alignment.centerLeft,
              mgBottom: 10,
              maxlines: 3,
            ),
            SignInForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/forgot-password',
                  );
                },
                child: const Text(
                  'Forgot password?',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
