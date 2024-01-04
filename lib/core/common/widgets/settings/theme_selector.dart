import 'package:demo/core/utils/theme_manager.dart';
import 'package:demo/src/app_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
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
      child: SizedBox(
        height: 48,
        child: Icon(
          isDark ? CupertinoIcons.sun_min_fill : CupertinoIcons.moon_stars,
          color: widget.color,
        ),
      ),
    );
  }
}
