import 'dart:async';

import 'package:demo/app/modules/auth/presenter/components/validate_email_button.dart';
import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({this.fromSplash = false, super.key});

  final bool fromSplash;

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final authCtrl = Modular.get<AuthController>();
  final profileCtrl = Modular.get<ProfileController>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    authCtrl.sendEmailVerification();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final result = await authCtrl.emailHasVerified();

      if (result) {
        timer.cancel();
        await profileCtrl.updateEmailVerified(emailVerified: result);
        await Modular.to.pushReplacementNamed('/home/');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/send_email.json',
              height: 170,
              repeat: false,
            ),
            SimpleText(
              mgTop: 40,
              alignment: Alignment.center,
              text: translation().verifyYourEmail,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
            SimpleText(
              mgTop: 20,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
              text: translation().verifyEmailDisclaimerOne,
              maxlines: 6,
            ),
            SimpleText(
              mgTop: 20,
              mgBottom: context.height * 0.07,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
              text: translation().verifyEmailDisclaimerTwo,
              maxlines: 6,
            ),
            const ValidateEmailButton(),
            TextButton(
              onPressed: () async {
                await authCtrl.sendEmailVerification();
                CoreUtils.bottomSnackBar(
                  translation().linkResent,
                  type: SnackBarType.alert,
                );
              },
              child: Text(translation().resendEmailLink),
            ),
            TextButton.icon(
              label: Text(
                widget.fromSplash
                    ? translation().goToLogin
                    : translation().backToLogin,
              ),
              onPressed: () async {
                await Modular.get<SessionController>().logOut();
                if (widget.fromSplash) {
                  await Modular.to.pushReplacementNamed('/auth/');
                } else {
                  Modular.to.pop();
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}
