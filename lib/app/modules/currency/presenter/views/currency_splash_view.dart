import 'dart:io';

import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/common/widgets/wave_animation.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class CurrencySplashView extends StatefulWidget {
  const CurrencySplashView({super.key});

  @override
  State<CurrencySplashView> createState() => _CurrencySplashViewState();
}

class _CurrencySplashViewState extends State<CurrencySplashView> {
  @override
  void initState() {
    super.initState();
    setFont(Fonts.montserrat);

    Future<void>.delayed(const Duration(seconds: 3))
        .then((value) => Modular.to.pushReplacementNamed('/home/currency/'));
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: ClipPath(
                  clipper: WaveShape(),
                  child: Container(
                    width: context.width,
                    height: 160,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ClipPath(
                  clipper: BottomWaveShape(),
                  child: Container(
                    width: context.width,
                    height: 160,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WaveAnimation(
                    centerChild: const Icon(
                      FontAwesome.money_bill_transfer_solid,
                      color: Colors.white,
                      size: 40,
                    ),
                    size: 150,
                    color: context.theme.primaryColor,
                  ),
                  const SimpleText(
                    mgTop: 10,
                    text: 'Currency Converter',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ],
              ),
            ],
          ),
        ),
        extendBody: true,
      ),
    );
  }
}
