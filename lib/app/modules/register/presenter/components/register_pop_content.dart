import 'package:demo/app/modules/auth/presenter/widgets/sign_up/privay_policy_button.dart';
import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/custom_input.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class RegisterPopContent extends StatelessWidget {
  const RegisterPopContent({
    required this.tabController,
    required this.formKey,
    super.key,
  });

  final TabController tabController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final txtCtrl = TextEditingController();
    final registerCtrl = Modular.get<RegisterController>();
    return SizedBox(
      height: 280,
      width: 320,
      child: DefaultTabController(
        length: 2,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/account_not_found.json',
                  height: 200,
                ),
                SimpleText(
                  mgTop: 20,
                  text: translation().userNotRegistered,
                  maxlines: 3,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/signup.json', height: 150),
                Form(
                  key: formKey,
                  child: CustomInput(
                    controller: txtCtrl,
                    autoFocus: true,
                    labelText: translation().fullName,
                    maxlines: 1,
                    mgTop: 20,
                    mgLeft: 10,
                    mgRight: 10,
                    validator: InputValidator.emptyCheck(
                      translation().requiredField,
                    ),
                    onChange: (value) => registerCtrl.name = value.trim(),
                  ),
                ),
                const PrivacyPolicyButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
