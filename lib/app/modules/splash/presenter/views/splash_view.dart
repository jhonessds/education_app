import 'dart:io';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

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
        Modular.to.pushReplacementNamed('/home/');
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
      child: Scaffold(
        body: SizedBox(
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: SvgPicture.asset(
                  'assets/svg/dev-jhones-colored.svg',
                  colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.onBackground,
                    BlendMode.srcIn,
                  ),
                  height: context.height * 0.23,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
