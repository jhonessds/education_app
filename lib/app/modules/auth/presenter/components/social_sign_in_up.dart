import 'package:demo/app/modules/auth/presenter/components/sign_in/login_anonymously_button.dart';
import 'package:demo/app/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/auth/presenter/validations/validate_auth_response.dart';
import 'package:demo/app/modules/auth/presenter/validations/validate_social_login.dart';
import 'package:demo/app/modules/auth/presenter/widgets/login_option_icon_button.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class SocialSignInUp extends StatelessWidget {
  const SocialSignInUp({
    this.isSignInView = true,
    super.key,
  });

  final bool isSignInView;

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
              loadingWidget();
              await sessionCtrl.logOut();
              authCtrl.authMethod = AuthMethodType.google;
              final result = await authCtrl.signInWithGoogle();
              Modular.to.pop();
              validateAuthResponse(success: result, isSignInView: isSignInView);
            });
          },
        ),
        LoginOptionIconButton(
          child: const Icon(Bootstrap.github),
          callback: () async {
            await validateSocialLogin(() async {
              await sessionCtrl.logOut();
              authCtrl.authMethod = AuthMethodType.github;
              final result = await authCtrl.signInWithGithub();
              validateAuthResponse(success: result, isSignInView: isSignInView);
            });
          },
        ),
        LoginOptionIconButton(
          child: Brand(Brands.facebook_circled),
          callback: () async {
            await validateSocialLogin(() async {
              await sessionCtrl.logOut();
              authCtrl.authMethod = AuthMethodType.facebook;
              final result = await authCtrl.signInWithFacebook();
              validateAuthResponse(success: result, isSignInView: isSignInView);
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
