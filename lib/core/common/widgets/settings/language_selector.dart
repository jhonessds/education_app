import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:flutter/material.dart';

Future<void> languageSelector() async {
  final context = NavigationService.instance.currentContext;
  await showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: languages
              .map(
                (lang) => ListTile(
                  leading: getLocaleFlag(lang.locale),
                  title: Text(lang.title),
                  onTap: () async {
                    await setLocale(lang).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  trailing: appConfigState.value.language.locale.languageCode ==
                          lang.locale.languageCode
                      ? const Icon(Icons.check)
                      : null,
                ),
              )
              .toList(),
        ),
      );
    },
  );
}
