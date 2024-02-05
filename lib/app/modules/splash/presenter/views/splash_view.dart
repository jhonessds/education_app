import 'dart:io';
import 'package:asp/asp.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final sessionCtrl = Modular.get<SessionController>();

  @override
  void initState() {
    super.initState();
    sessionCtrl.getSessionUser().then((value) {
      if (value) {
        if (currentUserState.value.verified) {
          Modular.to.pushReplacementNamed('/home/');
        } else {
          Modular.to.pushReplacementNamed('/verify-email', arguments: true);
        }
      } else {
        Modular.to.pushReplacementNamed('/auth/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(milliseconds: 50)).then(
      (_) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.light : Brightness.dark,
        ),
      ),
    );

    return PopScope(
      canPop: false,
      child: RxBuilder(
        builder: (context) {
          final isDarkMode = appConfigState.value.isDarkMode;
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/app/splash${isDarkMode ? '-dark' : ''}.png',
                    height: context.height * 0.28,
                  ),
                ),
                Positioned(
                  bottom: context.height * 0.3,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
            extendBody: true,
            bottomNavigationBar: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/app/brand${isDarkMode ? '-dark' : ''}.png',
                height: context.height * 0.1,
              ),
            ),
          );
        },
      ),
    );
  }
}
