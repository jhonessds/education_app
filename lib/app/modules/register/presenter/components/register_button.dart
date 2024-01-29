import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/register/presenter/controllers/register_controller.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    required this.txtButton,
    required this.tabController,
    required this.formKey,
    required this.registerCtrl,
    required this.authCtrl,
    super.key,
  });

  final ValueNotifier<String> txtButton;
  final TabController tabController;
  final GlobalKey<FormState> formKey;
  final RegisterController registerCtrl;
  final AuthController authCtrl;

  @override
  Widget build(BuildContext context) {
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
                  ..authType = authCtrl.authType;

                final result = await registerCtrl.registerLoggedUser();
                Modular.to.pop();

                if (result) {
                  CoreUtils.showSnackBar('suecce');
                } else {
                  CoreUtils.showSnackBar(
                    registerCtrl.errorMessage,
                    isError: true,
                  );
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
