import 'package:demo/app/app_widget.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/services/preferences/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DarkModeTile extends StatefulWidget {
  const DarkModeTile({
    super.key,
  });

  @override
  State<DarkModeTile> createState() => _DarkModeTileState();
}

class _DarkModeTileState extends State<DarkModeTile> {
  late ThemeMode actualTheme;
  bool isDark = false;
  @override
  void initState() {
    super.initState();
    getTheme().then(
      (value) => setState(
        () {
          actualTheme = value;
          isDark = actualTheme == ThemeMode.dark;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            isDark ? Iconsax.moon_outline : Iconsax.sun_1_outline,
          ),
          title: Text(
            translation().darkMode,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (_) async {
              var actualTheme = await getTheme();
              if (actualTheme == ThemeMode.dark) {
                actualTheme = await setTheme(ThemeMode.light);
              } else {
                actualTheme = await setTheme(ThemeMode.dark);
              }
              setState(() => isDark = actualTheme == ThemeMode.dark);
              if (mounted) {
                AppWidget.setTheme(context, actualTheme);
              }
            },
          ),
          onTap: () async {
            var actualTheme = await getTheme();
            if (actualTheme == ThemeMode.dark) {
              actualTheme = await setTheme(ThemeMode.light);
            } else {
              actualTheme = await setTheme(ThemeMode.dark);
            }
            setState(() => isDark = actualTheme == ThemeMode.dark);
            if (mounted) {
              AppWidget.setTheme(context, actualTheme);
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
