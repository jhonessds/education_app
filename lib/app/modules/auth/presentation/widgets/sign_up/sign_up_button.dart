import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({
    required this.formKey,
    required this.buttonKey,
    required this.email,
    required this.password,
    required this.fullName,
    required this.confirmPassword,
    super.key,
  });

  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final GlobalKey<FormState> formKey;
  final GlobalKey<State<StatefulWidget>> buttonKey;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  final btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      key: widget.buttonKey,
      height: 45,
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: screenSize.height * 0.01,
      ),
      child: RoundedLoadingButton(
        borderRadius: 70,
        color: Theme.of(context).primaryColor,
        controller: btnController,
        onPressed: () async {
          await FirebaseAuth.instance.currentUser?.reload();
          if (widget.formKey.currentState!.validate()) {
          } else {
            btnController.stop();
          }
        },
        width: screenSize.width,
        child: Text(
          translation().signUp,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
