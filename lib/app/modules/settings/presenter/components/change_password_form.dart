import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iconly/iconly.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    required this.formKey,
    super.key,
  });

  final GlobalKey<FormState> formKey;

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final oldPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final authCtrl = Modular.get<AuthController>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, right: 13, bottom: 20),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomInput(
              controller: oldPasswordCtrl,
              hintText: translation().oldPassword.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              validator: InputValidator.passValidator,
              onChange: (value) => authCtrl.password = value,
              sufixIcon: IconButton(
                onPressed: () => setState(() => obscureText = !obscureText),
                icon: Icon(
                  obscureText ? IconlyLight.show : IconlyLight.hide,
                  color: Colors.grey,
                ),
              ),
            ),
            CustomInput(
              controller: newPasswordCtrl,
              hintText: translation().newPassword.capitalize,
              obscureText: obscureText,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              mgBottom: 10,
              onChange: (value) => authCtrl.newPassword = value,
              validator: (t) {
                if (t == null || t.isEmpty) return translation().enterAPassword;

                if (t == oldPasswordCtrl.text) {
                  return translation().passwordNeedDifferent;
                }

                return null;
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
