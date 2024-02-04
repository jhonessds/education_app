import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.formKey,
    required this.buttonKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey buttonKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscureText = true;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final authCtrl = Modular.get<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomInput(
              controller: emailCtrl,
              labelText: translation().email.capitalize,
              keyboardType: TextInputType.emailAddress,
              mgBottom: 20,
              borderRadius: 70,
              validator: InputValidator.emailValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) {
                authCtrl.email = emailCtrl.text.trim();
                CoreUtils.scrollTo(widget.buttonKey);
              },
              onTapOutside: () {},
            ),
            CustomInput(
              controller: passwordCtrl,
              labelText: translation().password.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              validator: InputValidator.passValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) {
                authCtrl.password = passwordCtrl.text;
                CoreUtils.scrollTo(widget.buttonKey);
              },
              sufixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: Icon(
                  obscureText ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
