import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/views/verify_email_view.dart';
import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    required this.tabController,
    required this.formKey,
    required this.isSignInView,
    super.key,
  });

  final TabController tabController;
  final GlobalKey<FormState> formKey;
  final bool isSignInView;
  @override
  Widget build(BuildContext context) {
    final registerCtrl = Modular.get<RegisterController>();
    final authCtrl = Modular.get<AuthController>();
    final txtButton = ValueNotifier<String>(
      isSignInView ? translation().yes : translation().signUp,
    );

    return ValueListenableBuilder<String>(
      valueListenable: txtButton,
      builder: (context, value, child) {
        return TextButton(
          child: Text(value),
          onPressed: () async {
            if (tabController.index == 1) {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(context);
                loadingWidget();

                registerCtrl
                  ..password = authCtrl.password
                  ..email = authCtrl.email
                  ..authMethod = authCtrl.authMethod;

                final result = await registerCtrl.registerLoggedUser();
                Modular.to.pop();

                if (result) {
                  if (authCtrl.authMethod == AuthMethodType.email) {
                    await Modular.to.push(
                      CoreUtils.push<void>(const VerifyEmailView()),
                    );
                  } else {
                    await Modular.to.pushReplacementNamed('/home/');
                  }
                } else {
                  CoreUtils.bottomSnackBar(registerCtrl.errorMessage);
                }
              }
            } else {
              tabController.index = 1;
              txtButton.value = translation().signUp;
            }
          },
        );
      },
    );
  }
}
