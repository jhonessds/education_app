import 'package:education_app/src/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

class SignInRowButton extends StatelessWidget {
  const SignInRowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Sign in to your account.'),
          // Baseline(
          //   baseline: 100,
          //   baselineType: TextBaseline.alphabetic,
          //   child: TextButton(
          //     onPressed: () {
          //       Navigator.pushReplacementNamed(
          //         context,
          //         SignInView.routeName,
          //       );
          //     },
          //     child: const Text('Register account?'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
