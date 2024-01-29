import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/environments/flavors_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

Future<void> validateSocialLogin(Future<void> Function() callback) async {
  if (FlavorConfig.isProduction) {
    await callback();
  } else {
    customAlert(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/access_denied.json',
            height: 170,
            repeat: false,
          ),
          const SimpleText(
            mgTop: 20,
            text: 'Disponível apenas em produção',
            maxlines: 10,
          ),
        ],
      ),
      showOkBtn: true,
      callback: () => Modular.to.pop(),
    );
  }
}
