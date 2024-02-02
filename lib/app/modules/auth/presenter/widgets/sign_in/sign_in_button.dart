import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/auth/presenter/validations/validate_auth_response.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/extensions/context_extension.dart';
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
  final authCtrl = Modular.get<AuthController>();
  final sessionCtrl = Modular.get<SessionController>();

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
            await sessionCtrl.logOut();
            final result = await authCtrl.signInWithEmail();
            btnController.stop();
            validateAuthResponse(success: result);
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
