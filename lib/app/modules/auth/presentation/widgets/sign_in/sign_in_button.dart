import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
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
            final result = await controller.signInWithEmail(
              widget.email,
              widget.password,
            );
            btnController.stop();
            if (result) {
              CoreUtils.showSnackBar('Sucesso!');
            } else {
              if (controller.isRegistred) {
                CoreUtils.showSnackBar(
                  controller.failure.message!,
                  isError: true,
                );
              } else {
                // ignore: use_build_context_synchronously
                await showDialog<void>(
                  context: context,
                  builder: (_) => Container(),
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
