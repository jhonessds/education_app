import 'package:demo/app/app_widget.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      icon: SizedBox(
        height: 30,
        child: Icon(
          Icons.translate,
          color: color ?? context.theme.colorScheme.onBackground,
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem('English', () async {
          await setLocale('en').then((locale) {
            AppWidget.setLocale(context, locale);
          });
        }),
        _buildPopupMenuItem('Español', () async {
          await setLocale('es').then((locale) {
            AppWidget.setLocale(context, locale);
          });
        }),
        _buildPopupMenuItem('Português', () async {
          await setLocale('pt').then((locale) {
            AppWidget.setLocale(context, locale);
          });
        }),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String title,
    void Function() onTap,
  ) {
    return PopupMenuItem(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
          ),
        ],
      ),
    );
  }
}
