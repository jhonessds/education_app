import 'package:education_app/core/common/widgets/custom_input.dart';
import 'package:education_app/core/utils/language_constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
              controller: widget.emailController,
              hintText: translation().email.capitalize,
              keyboardType: TextInputType.emailAddress,
              mgBottom: 25,
              borderRadius: 70,
              validator: InputValidator.emailValidator,
            ),
            CustomInput(
              controller: widget.passwordController,
              hintText: translation().password.capitalize,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              maxlines: 1,
              borderRadius: 70,
              validator: InputValidator.emptyCheck('required field'),
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
