import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/widgets/custom_alert.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
    String message, {
    bool isError = false,
    Widget? icon,
  }) {
    final context = NavigationService.instance.currentContext;
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              if (icon != null) icon,
              if (icon != null) const SizedBox(width: 5),
              Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: isError
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void popAnimated(
    String animaton, {
    String? text,
    void Function()? callback,
  }) {
    customAlert(
      showOkBtn: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/$animaton.json',
            height: 150,
            repeat: false,
          ),
          Visibility(
            visible: text != null,
            child: SimpleText(
              mgTop: 20,
              text: text!,
              maxlines: 3,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
          ),
        ],
      ),
      callback: () {
        final context = NavigationService.instance.currentContext;
        Navigator.of(context).pop();
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
