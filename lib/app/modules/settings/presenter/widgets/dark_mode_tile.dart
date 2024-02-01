import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/services/preferences/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            appConfigState.value.isDarkMode
                ? Iconsax.moon_outline
                : Iconsax.sun_1_outline,
          ),
          title: Text(
            translation().darkMode,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: Switch(
            value: appConfigState.value.isDarkMode,
            onChanged: (_) async {
              if (appConfigState.value.isDarkMode) {
                await setTheme(ThemeMode.light);
              } else {
                await setTheme(ThemeMode.dark);
              }
            },
          ),
          onTap: () async {
            if (appConfigState.value.isDarkMode) {
              await setTheme(ThemeMode.light);
            } else {
              await setTheme(ThemeMode.dark);
            }
          },
        ),
        Divider(
          color: context.theme.disabledColor,
          indent: 10,
          endIndent: 10,
          height: 5,
        ),
      ],
    );
  }
}
