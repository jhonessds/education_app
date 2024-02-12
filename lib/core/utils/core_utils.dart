import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:demo/app/app_widget.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

class CoreUtils {
  const CoreUtils._();

  static Widget getFlag({
    required String currencyCode,
    double size = 35,
  }) {
    switch (currencyCode) {
      case 'USD':
        return Flag(Flags.united_states_of_america, size: size);
      case 'EUR':
        return Flag(Flags.european_union, size: size);
      case 'GBP':
        return Flag(Flags.united_kingdom, size: size);
      case 'ARS':
        return Flag(Flags.argentina, size: size);
      case 'BRL':
        return Flag(Flags.brazil, size: size);
      case 'CAD':
        return Flag(Flags.canada, size: size);
      case 'AUD':
        return Flag(Flags.australia, size: size);
      case 'JPY':
        return Flag(Flags.japan, size: size);
      case 'CNY':
        return Flag(Flags.china, size: size);
      case 'BTC':
        return Icon(Iconsax.bitcoin_btc_outline, size: size);
      default:
        return Flag(Flags.brazil, size: size);
    }
  }

  static CustomTransition customTransition() {
    return CustomTransition(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child,
          ),
        );
      },
    );
  }

  static PageRouteBuilder<T> push<T>(Widget child) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child,
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child,
          ),
        );
      },
    );
  }

  static void bottomSnackBar(
    String message, {
    SnackBarType type = SnackBarType.fail,
  }) {
    final context = NavigationService.instance.currentContext;

    IconSnackBar.show(
      duration: const Duration(seconds: 4),
      context: context,
      snackBarType: type,
      label: message,
    );
  }

  static void topSnackBar(
    String message, {
    AnimatedSnackBarType type = AnimatedSnackBarType.error,
  }) {
    final context = NavigationService.instance.currentContext;

    AnimatedSnackBar.material(
      message,
      type: type,
      duration: const Duration(seconds: 4),
      mobilePositionSettings: MobilePositionSettings(
        topOnAppearance: context.height * 0.04,
        bottomOnAppearance: context.height * 0.05,
      ),
    ).show(context);
  }

  static void popAnimated(
    String animaton, {
    String? text,
    void Function()? callback,
    bool showOkBtn = true,
    bool repeat = false,
  }) {
    customAlert(
      showOkBtn: showOkBtn,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/$animaton.json',
            height: 150,
            repeat: repeat,
          ),
          if (text != null)
            SimpleText(
              mgTop: 20,
              text: text,
              maxlines: 3,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
        ],
      ),
      callback: () {
        Modular.to.pop();
        callback?.call();
      },
    );
  }

  static void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1),
      alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
    );
  }
}
