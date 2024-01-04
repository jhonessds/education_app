import 'package:demo/core/utils/language_constants.dart';
import 'package:demo/src/app_widget.dart';
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
          color: color,
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem('English', () async {
          final locale = await setLocale('en');
          // ignore: use_build_context_synchronously
          AppWidget.setLocale(context, locale);
        }),
        _buildPopupMenuItem('Español', () async {
          final locale = await setLocale('es');
          // ignore: use_build_context_synchronously
          AppWidget.setLocale(context, locale);
        }),
        _buildPopupMenuItem('Português', () async {
          final locale = await setLocale('pt');
          // ignore: use_build_context_synchronously
          AppWidget.setLocale(context, locale);
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
