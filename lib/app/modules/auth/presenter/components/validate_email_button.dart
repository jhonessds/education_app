import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ValidateEmailButton extends StatefulWidget {
  const ValidateEmailButton({
    super.key,
  });

  @override
  State<ValidateEmailButton> createState() => _ValidateEmailButtonState();
}

class _ValidateEmailButtonState extends State<ValidateEmailButton> {
  final btnController = RoundedLoadingButtonController();
  final authCtrl = Modular.get<AuthController>();
  final profileCtrl = Modular.get<ProfileController>();

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
          final result = await authCtrl.emailHasVerified();
          btnController.stop();
          if (result) {
            await profileCtrl.updateEmailVerified(emailVerified: result);
            await Modular.to.pushReplacementNamed('/home/');
          } else {
            CoreUtils.bottomSnackBar(
              'email ainda nao foi verificado',
              type: SnackBarType.alert,
            );
          }
        },
        width: context.width,
        child: Text(
          translation().continues,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
