import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/src/auth/presentation/widgets/login_option_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SignUpRow extends StatelessWidget {
  const SignUpRow({
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
          callback: () async {
            CoreUtils.popAnimated('send_email', text: 'In development');
          },
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
      ],
    );
  }
}
