import 'package:demo/app/app_widget.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({super.key, this.color});
  final Color? color;

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
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
    return IconButton(
      splashRadius: 25,
      onPressed: () async {
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
      icon: Icon(
        isDark ? FontAwesome.sun : FontAwesome.moon,
        color: widget.color ?? context.theme.colorScheme.onBackground,
      ),
    );
  }
}
