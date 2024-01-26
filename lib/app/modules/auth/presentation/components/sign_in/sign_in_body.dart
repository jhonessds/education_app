import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/app/modules/auth/presentation/components/sign_in/login_row.dart';
import 'package:demo/app/modules/auth/presentation/components/sign_in/sign_in_form.dart';
import 'package:demo/app/modules/auth/presentation/widgets/sign_in/sign_in_button.dart';
import 'package:demo/app/modules/auth/presentation/widgets/top_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({required this.state, super.key});
  final AuthState state;

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final buttonKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  Theme.of(context).colorScheme.onBackground,
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
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            Container(
              margin: EdgeInsets.only(right: 6, bottom: context.height * 0.02),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: Text(translation().forgotPassword),
                ),
              ),
            ),
            SignInButton(
              formKey: formKey,
              buttonKey: buttonKey,
              email: emailController.text,
              password: passwordController.text,
            ),
            SimpleText(
              mgTop: 10,
              mgBottom: context.height * 0.01,
              text: '- ${translation().or} -',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor,
            ),
            const LoginRow(),
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
                        Navigator.pushReplacementNamed(context, '/sign-up');
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
