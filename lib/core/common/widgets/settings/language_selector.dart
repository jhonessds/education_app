import 'package:demo/app/app_widget.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> languageSelector() async {
  final context = NavigationService.instance.currentContext;
  final sessionCtrl = Modular.get<SessionController>();
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
                      sessionCtrl.setLanguageCode(
                        languageCode: lang.locale.languageCode,
                      );
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
