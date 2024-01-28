import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/register/presenter/components/register_pop.dart';
import 'package:demo/core/abstraction/logger.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({
    required this.formKey,
    required this.buttonKey,
    super.key,
  });

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
    return Container(
      key: widget.buttonKey,
      height: 45,
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: context.height * 0.01,
      ),
      child: RoundedLoadingButton(
        borderRadius: 70,
        color: context.theme.primaryColor,
        controller: btnController,
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            final result = await controller.signInWithEmail();
            btnController.stop();
            logger(FirebaseAuth.instance.currentUser);
            if (result) {
              CoreUtils.showSnackBar('Sucesso!');
            } else {
              if (controller.isRegistred) {
                CoreUtils.showSnackBar(controller.errorMessage, isError: true);
              } else {
                // ignore: use_build_context_synchronously
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const RegisterDialog(),
                );
              }
            }
          } else {
            btnController.stop();
          }
        },
        width: context.width,
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
