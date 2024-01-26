import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({
    required this.formKey,
    required this.buttonKey,
    required this.email,
    required this.password,
    super.key,
  });

  final String email;
  final String password;
  final GlobalKey<FormState> formKey;
  final GlobalKey<State<StatefulWidget>> buttonKey;

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  final btnController = RoundedLoadingButtonController();
  final controller = Modular.get<AuthController>();

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
            await controller.signInWithEmail(widget.email, widget.password);
          } else {
            btnController.stop();
          }
        },
        width: screenSize.width,
        child: Text(
          translation().signIn,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
