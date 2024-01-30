import 'package:another_flushbar/flushbar.dart';
import 'package:demo/app/app_widget.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/notifications/notification_model.dart';
import 'package:flutter/material.dart';

Future<void> showNotificationAlert(
  NotificationModel notification,
) async {
  final context = NavigationService.instance.currentContext;

  await precacheImage(const AssetImage('assets/icons/app-icon.png'), context);

  if (context.mounted) {
    await Flushbar<void>(
      title: notification.title,
      message: notification.body,
      messageColor: context.theme.colorScheme.onBackground,
      titleColor: context.theme.colorScheme.onBackground,
      duration: const Duration(seconds: 6),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      backgroundColor: context.theme.cardColor,
      margin: const EdgeInsets.all(10),
      icon: Container(
        margin: const EdgeInsets.only(left: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset('assets/app/icon-dev.png'),
        ),
      ),
    ).show(context);
  }
}
