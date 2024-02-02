import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconly/iconly.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.formKey,
    required this.buttonKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey buttonKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final fullNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final registerCtrl = Modular.get<RegisterController>();
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
              controller: fullNameCtrl,
              hintText: translation().fullName,
              mgBottom: 10,
              borderRadius: 70,
              validator: InputValidator.emptyCheck('campo obrigatorio'),
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (value) {
                registerCtrl.name = value.trim();
                CoreUtils.scrollTo(widget.buttonKey);
              },
              onTapOutside: () {},
            ),
            CustomInput(
              controller: emailCtrl,
              hintText: translation().email.capitalize,
              keyboardType: TextInputType.emailAddress,
              mgBottom: 10,
              borderRadius: 70,
              validator: InputValidator.emailValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (value) {
                registerCtrl.email = value.trim();
                CoreUtils.scrollTo(widget.buttonKey);
              },
              onTapOutside: () {},
            ),
            CustomInput(
              controller: passwordCtrl,
              hintText: translation().password.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              validator: InputValidator.passValidator,
              onTap: () => CoreUtils.scrollTo(widget.buttonKey),
              onChange: (value) {
                registerCtrl.password = value;
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
            CustomInput(
              controller: confirmPasswordCtrl,
              hintText: translation().confirmPassword.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              validator: (t) {
                if (t == null || t.isEmpty) return 'Confirme a senha';

                if (t != passwordCtrl.text) {
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
