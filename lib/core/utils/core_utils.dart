import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:demo/app/app_widget.dart';
import 'package:demo/core/abstraction/icon_snack_bar.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class CoreUtils {
  const CoreUtils._();

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

  static PageRouteBuilder<void> push(Widget child) {
    return PageRouteBuilder<void>(
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
