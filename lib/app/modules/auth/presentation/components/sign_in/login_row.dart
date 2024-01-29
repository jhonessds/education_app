import 'package:demo/app/modules/auth/presentation/components/sign_in/login_anonymously_button.dart';
import 'package:demo/app/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/app/modules/auth/presentation/validations/validate_social_login.dart';
import 'package:demo/app/modules/auth/presentation/validations/validte_auth_response.dart';
import 'package:demo/app/modules/auth/presentation/widgets/login_option_icon_button.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authCtrl = Modular.get<AuthController>();
    final sessionCtrl = Modular.get<SessionController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginOptionIconButton(
          child: const Icon(
            FontAwesome.apple_brand,
            size: 22,
          ),
          callback: () async {
            CoreUtils.popAnimated('send_email', text: 'In development');
          },
        ),
        LoginOptionIconButton(
          child: Brand(Brands.google),
          callback: () async {
            await validateSocialLogin(() async {
              await sessionCtrl.logOut();
              authCtrl.authType = AuthMethodType.google;
              final result = await authCtrl.signInWithGoogle();
              validateAuthResponse(success: result);
            });
          },
        ),
        LoginOptionIconButton(
          child: const Icon(Bootstrap.github),
          callback: () async {
            await validateSocialLogin(() async {
              await sessionCtrl.logOut();
              authCtrl.authType = AuthMethodType.github;
              final result = await authCtrl.signInWithGithub();
              validateAuthResponse(success: result);
            });
          },
        ),
        LoginOptionIconButton(
          child: Brand(Brands.facebook_circled),
          callback: () async {
            await validateSocialLogin(() async {
              await sessionCtrl.logOut();
              authCtrl.authType = AuthMethodType.facebook;
              final result = await authCtrl.signInWithFacebook();
              validateAuthResponse(success: result);
            });
          },
        ),
        LoginAnonymouslyButton(
          sessionCtrl: sessionCtrl,
          authCtrl: authCtrl,
        ),
      ],
    );
  }
}
