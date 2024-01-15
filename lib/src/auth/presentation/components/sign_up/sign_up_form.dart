import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/language_constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.formKey,
    required this.buttonKey,
    required this.fullNameCtrl,
    required this.confirmPasswordCtrl,
    super.key,
  });

  final TextEditingController fullNameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final GlobalKey<FormState> formKey;
  final GlobalKey buttonKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomInput(
              controller: widget.fullNameCtrl,
              hintText: translation().fullName,
              mgBottom: 10,
              borderRadius: 70,
              validator: InputValidator.emptyCheck('campo obrigatorio'),
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) => CoreUtils.scrollTo(widget.buttonKey),
              onTapOutside: () {},
            ),
            CustomInput(
              controller: widget.emailCtrl,
              hintText: translation().email.capitalize,
              keyboardType: TextInputType.emailAddress,
              mgBottom: 10,
              borderRadius: 70,
              validator: InputValidator.emailValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) => CoreUtils.scrollTo(widget.buttonKey),
              onTapOutside: () {},
            ),
            CustomInput(
              controller: widget.passwordCtrl,
              hintText: translation().password.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              validator: InputValidator.passValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) => CoreUtils.scrollTo(widget.buttonKey),
              sufixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: Icon(
                  obscureText ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
            ),
            CustomInput(
              controller: widget.confirmPasswordCtrl,
              hintText: translation().confirmPassword.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              validator: (t) {
                if (t == null || t.isEmpty) return 'Confirme a senha';

                if (t != widget.passwordCtrl.text) {
                  return 'Senhas precisam ser iguais';
                }

                return null;
              },
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (_) => CoreUtils.scrollTo(widget.buttonKey),
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
