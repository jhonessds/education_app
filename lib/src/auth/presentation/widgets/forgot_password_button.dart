import 'package:education_app/core/common/widgets/custom_alert.dart';
import 'package:education_app/core/common/widgets/simple_text.dart';
import 'package:education_app/core/utils/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final btnCtrl = RoundedLoadingButtonController();

    return Container(
      key: buttonKey,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: RoundedLoadingButton(
        borderRadius: 10,
        color: Theme.of(context).primaryColor,
        controller: btnCtrl,
        onPressed: () async {
          if (formKeyEmail.currentState!.validate()) {
            linkPop(context);
          } else {
            btnCtrl.stop();
          }
        },
        width: screenSize.width,
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

  void linkPop(BuildContext context) {
    customAlert(
      showOkBtn: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/send_email.json',
            repeat: false,
          ),
          SimpleText(
            mgTop: 20,
            text: translation().passwordResetLink,
            maxlines: 3,
            textAlign: TextAlign.center,
            fontSize: 16,
          ),
        ],
      ),
      callback: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );
  }
}
