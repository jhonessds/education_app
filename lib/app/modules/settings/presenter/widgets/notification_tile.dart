import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Iconsax.notification_status_outline),
          title: const Text(
            'Push Notification',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: Switch(value: true, onChanged: (_) {}),
          onTap: () {},
        ),
        Divider(
          color: context.theme.disabledColor,
          indent: 10,
          endIndent: 10,
          height: 10,
        ),
      ],
    );
  }
}
