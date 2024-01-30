import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({
    required this.formKey,
    required this.buttonKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<State<StatefulWidget>> buttonKey;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  final btnController = RoundedLoadingButtonController();
  final registerCtrl = Modular.get<RegisterController>();

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
        color: Theme.of(context).primaryColor,
        controller: btnController,
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            registerCtrl.authMethod = AuthMethodType.email;
            final result = await registerCtrl.registerUser();
            btnController.stop();

            if (result) {
              CoreUtils.showSnackBar('Sucesso!');
            } else {
              CoreUtils.showSnackBar(registerCtrl.errorMessage, isError: true);
            }
          } else {
            btnController.stop();
          }
        },
        width: context.width,
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
