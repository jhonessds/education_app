import 'package:demo/app/app_widget.dart';
import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/views/verify_email_view.dart';
import 'package:demo/app/modules/register/presenter/components/register_pop.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void validateAuthResponse({required bool success, bool isSignInView = true}) {
  final authCtrl = Modular.get<AuthController>();
  final context = NavigationService.instance.currentContext;
  if (success) {
    if (currentUserState.value.verified) {
      Modular.to.pushReplacementNamed('/home/');
    } else {
      Modular.to.push(CoreUtils.push<void>(const VerifyEmailView()));
    }
  } else {
    if (authCtrl.isRegistred) {
      CoreUtils.bottomSnackBar(authCtrl.errorMessage);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => RegisterDialog(isSignInView: isSignInView),
      );
    }
  }
}
