import 'package:demo/app/modules/auth/presentation/components/sign_up/privacy_policy.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrivacyPolicyButton extends StatelessWidget {
  const PrivacyPolicyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customAlert(
          showOkBtn: true,
          content: const PrivacyPolicy(),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 20,
          ),
          contentPadding: 15,
          callback: () => Modular.to.pop(),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: translation().byRegisteringYouAgreeToOur,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: ' ${translation().privacyPolicy}',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
