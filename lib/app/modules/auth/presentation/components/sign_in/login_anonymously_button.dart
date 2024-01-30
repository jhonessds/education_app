import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/app/modules/auth/presentation/validations/validate_auth_response.dart';
import 'package:demo/app/modules/auth/presentation/widgets/login_option_icon_button.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

class LoginAnonymouslyButton extends StatelessWidget {
  const LoginAnonymouslyButton({
    required this.sessionCtrl,
    required this.authCtrl,
    super.key,
  });

  final SessionController sessionCtrl;
  final AuthController authCtrl;

  @override
  Widget build(BuildContext context) {
    return LoginOptionIconButton(
      child: const Icon(
        FontAwesome.user_secret_solid,
        size: 22,
      ),
      callback: () {
        customAlert(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/lottie/incognito.json'),
              const SimpleText(
                text: 'Ao iniciar a sessão anonimamente você não '
                    'será capaz de sincronizar os dados, e tera acesso '
                    'limitado a certos recursos. Deseja continuar?',
                maxlines: 10,
              ),
            ],
          ),
          callback: () async {
            Modular.to.pop();
            loadingWidget();
            await sessionCtrl.logOut();
            authCtrl.authMethod = AuthMethodType.anonymous;
            final result = await authCtrl.signInAnonymously();
            Modular.to.pop();
            validateAuthResponse(success: result);
          },
        );
      },
    );
  }
}
