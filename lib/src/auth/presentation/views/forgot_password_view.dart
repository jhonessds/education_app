import 'package:education_app/core/common/widgets/custom_input.dart';
import 'package:education_app/core/common/widgets/simple_text.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/core/utils/language_constants.dart';
import 'package:education_app/src/auth/presentation/widgets/forgot_password_button.dart';
import 'package:education_app/src/auth/presentation/widgets/top_animation.dart';
import 'package:education_app/src/auth/presentation/widgets/top_title.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final formKeyEmail = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const TopAnimation(
                animation: 'forgot',
                minHeight: 270,
                maxHeight: 270,
              ),
              TopTitle(title: translation().forgotPassword),
              SimpleText(
                mgLeft: 13,
                mgRight: 13,
                text: translation().dontWorryResetPass,
                fontSize: 16,
                alignment: Alignment.centerLeft,
                mgBottom: 20,
                maxlines: 3,
              ),
              Form(
                key: formKeyEmail,
                child: CustomInput(
                  controller: emailCtrl,
                  borderRadius: 90,
                  mgBottom: 16,
                  mgTop: 10,
                  mgLeft: 13,
                  mgRight: 13,
                  maxlines: 1,
                  hintText: translation().email,
                  keyboardType: TextInputType.emailAddress,
                  validator: InputValidator.emailValidator,
                  onTap: () => CoreUtils.scrollTo(buttonKey),
                  onChange: (_) => CoreUtils.scrollTo(buttonKey),
                ),
              ),
              ForgotPasswordButton(
                buttonKey: buttonKey,
                emailCtrl: emailCtrl,
                formKeyEmail: formKeyEmail,
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  translation().goBack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
