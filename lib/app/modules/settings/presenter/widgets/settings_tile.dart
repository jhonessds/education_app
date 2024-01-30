import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.icon,
    required this.title,
    super.key,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: Icon(
            Iconsax.arrow_right_1_outline,
            size: 18,
            color: context.theme.primaryColor,
          ),
          onTap: onTap,
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
