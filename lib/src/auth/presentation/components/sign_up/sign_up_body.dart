import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/language_constants.dart';
import 'package:demo/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:demo/src/auth/presentation/components/sign_in/login_row.dart';
import 'package:demo/src/auth/presentation/components/sign_up/sign_up_form.dart';
import 'package:demo/src/auth/presentation/components/sign_up/sign_up_row.dart';
import 'package:demo/src/auth/presentation/widgets/sign_in/sign_in_button.dart';
import 'package:demo/src/auth/presentation/widgets/top_animation.dart';
import 'package:demo/src/auth/presentation/widgets/top_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({
    required this.state,
    required this.emailCtrl,
    required this.passwordCtrl,
    super.key,
  });

  final AuthState state;
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

            // Container(
            //   margin: const EdgeInsets.only(top: 15),
            //   child: SvgPicture.asset(
            //     'assets/svg/dev-jhones.svg',
            //     colorFilter: ColorFilter.mode(
            //       Theme.of(context).colorScheme.onBackground,
            //       BlendMode.srcIn,
            //     ),
            //     height: context.height * 0.23,
            //   ),
            // ),
            const TopTitle(
              title: 'Cadastre-se para liberar todos os recursos.',
            ),

            SignUpForm(
              emailCtrl: widget.emailCtrl,
              confirmPasswordCtrl: confirmaPasswordCtrl,
              fullNameCtrl: fullNameCtrl,
              passwordCtrl: widget.passwordCtrl,
              formKey: formKey,
              buttonKey: buttonKey,
            ),
            Container(height: context.height * 0.02),
            SignInButton(
              formKey: formKey,
              buttonKey: buttonKey,
              email: widget.emailCtrl.text,
              password: widget.passwordCtrl.text,
            ),
            SimpleText(
              mgTop: 10,
              mgBottom: context.height * 0.01,
              text: '- ${translation().or} -',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).disabledColor,
            ),
            const SignUpRow(),
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
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/sign-in');
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
