import 'package:demo/app/modules/auth/presenter/components/sign_in/sign_in_form.dart';
import 'package:demo/app/modules/auth/presenter/components/social_sign_in_up.dart';
import 'package:demo/app/modules/auth/presenter/views/forgot_password_view.dart';
import 'package:demo/app/modules/auth/presenter/views/sign_up_view.dart';
import 'package:demo/app/modules/auth/presenter/widgets/sign_in/sign_in_button.dart';
import 'package:demo/app/modules/auth/presenter/widgets/top_title.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final formKey = GlobalKey<FormState>();
  final buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: SvgPicture.asset(
                'assets/svg/dev-jhones.svg',
                colorFilter: ColorFilter.mode(
                  context.theme.colorScheme.onBackground,
                  BlendMode.srcIn,
                ),
                height: context.height * 0.23,
              ),
            ),
            TopTitle(title: translation().discoverEverythingWeCanOffer),
            SimpleText(
              mgLeft: 13,
              mgRight: 13,
              text: translation().signInToYourAccount,
              fontSize: 16,
              alignment: Alignment.centerLeft,
              mgBottom: 10,
              maxlines: 3,
            ),
            SignInForm(
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            Container(
              margin: EdgeInsets.only(right: 6, bottom: context.height * 0.02),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Modular.to.push(CoreUtils.push(const ForgotPasswordView()));
                  },
                  child: Text(translation().forgotPassword),
                ),
              ),
            ),
            SignInButton(
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            SimpleText(
              mgTop: 10,
              mgBottom: context.height * 0.01,
              text: '- ${translation().or} -',
              fontWeight: FontWeight.bold,
              color: context.theme.disabledColor,
            ),
            const SocialSignInUp(),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 60),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleText(
                    text: translation().dontHaveAccount,
                    withTextScale: false,
                  ),
                  SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Modular.to.push(CoreUtils.push(const SignUpView()));
                      },
                      child: SimpleText(
                        text: translation().signUp,
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
