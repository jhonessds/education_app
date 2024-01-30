import 'package:demo/app/modules/auth/presentation/components/sign_up/sign_up_form.dart';
import 'package:demo/app/modules/auth/presentation/components/social_sign_in_up.dart';
import 'package:demo/app/modules/auth/presentation/widgets/sign_up/sign_up_button.dart';
import 'package:demo/app/modules/auth/presentation/widgets/top_title.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({
    required this.emailCtrl,
    required this.passwordCtrl,
    super.key,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final fullNameCtrl = TextEditingController();
  final confirmaPasswordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final buttonKey = GlobalKey();

  @override
  void dispose() {
    fullNameCtrl.dispose();
    confirmaPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.22,
              child: Lottie.asset('assets/lottie/signup.json'),
            ),
            const TopTitle(
              title: 'Cadastre-se para liberar todos os recursos.',
            ),
            SignUpForm(
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            Container(height: context.height * 0.02),
            SignUpButton(
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            SimpleText(
              mgTop: 10,
              mgBottom: context.height * 0.01,
              text: '- ${translation().or} -',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor,
            ),
            const SocialSignInUp(isSignInView: false),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 60),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleText(
                    text: translation().alreadyHaveAccount,
                    withTextScale: false,
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () => Modular.to.pop(),
                      child: SimpleText(
                        text: translation().signIn,
                        fontWeight: FontWeight.bold,
                        withTextScale: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
