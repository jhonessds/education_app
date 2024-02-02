import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ChangePasswordButton extends StatefulWidget {
  const ChangePasswordButton({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<ChangePasswordButton> createState() => _ChangePasswordButtonState();
}

class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  final btnController = RoundedLoadingButtonController();
  final authCtrl = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.only(
        left: 13,
        right: 13,
        bottom: context.height * 0.02,
      ),
      child: RoundedLoadingButton(
        borderRadius: 70,
        color: Theme.of(context).primaryColor,
        controller: btnController,
        onPressed: () async {
          if (widget.formKey.currentState!.validate()) {
            final result = await authCtrl.updatePassword();
            btnController.stop();
            if (result) {
              Modular.to.pop();
              CoreUtils.bottomSnackBar(
                translation().passwordChanged,
                type: SnackBarType.save,
              );
            } else {
              CoreUtils.topSnackBar(authCtrl.errorMessage);
            }
          } else {
            btnController.stop();
          }
        },
        width: context.width,
        child: Text(
          translation().save,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
