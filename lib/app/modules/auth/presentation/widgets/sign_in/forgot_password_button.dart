import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordButton extends StatefulWidget {
  const ForgotPasswordButton({
    required this.emailCtrl,
    required this.buttonKey,
    required this.formKeyEmail,
    super.key,
  });
  final TextEditingController emailCtrl;
  final GlobalKey<State<StatefulWidget>> buttonKey;
  final GlobalKey<FormState> formKeyEmail;

  @override
  State<ForgotPasswordButton> createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordButton> {
  final btnCtrl = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.buttonKey,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: RoundedLoadingButton(
        borderRadius: 70,
        color: Theme.of(context).primaryColor,
        controller: btnCtrl,
        onPressed: () async {
          if (widget.formKeyEmail.currentState!.validate()) {
            final authCtrl = Modular.get<AuthController>();
            final result = await authCtrl.forgotPassword(
              email: widget.emailCtrl.text,
            );

            btnCtrl.stop();

            if (result) {
              CoreUtils.popAnimated(
                'send_email',
                text: translation().passwordResetLink,
                callback: () => Modular.to.pop(),
              );
            } else {
              CoreUtils.showSnackBar(authCtrl.errorMessage, isError: true);
            }
          } else {
            btnCtrl.stop();
          }
        },
        width: context.width,
        child: Text(
          translation().send,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
