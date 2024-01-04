import 'package:demo/src/auth/presentation/widgets/sign_in/login_option_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginOptionIconButton(
          child: const Icon(
            FontAwesome.apple_brand,
            size: 22,
          ),
          callback: () async {},
        ),
        LoginOptionIconButton(
          child: Brand(Brands.google),
          callback: () async {},
        ),
        LoginOptionIconButton(
          child: const Icon(Bootstrap.github),
          callback: () {},
        ),
        LoginOptionIconButton(
          child: Brand(Brands.facebook_circled),
          callback: () {},
        ),
        LoginOptionIconButton(
          child: const Icon(
            FontAwesome.user_secret_solid,
            size: 22,
          ),
          callback: () {},
        ),
      ],
    );
  }
}
