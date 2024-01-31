import 'package:asp/asp.dart';
import 'package:demo/app/app_widget.dart';
import 'package:demo/app/modules/settings/presenter/controllers/states/setting_state.dart';
import 'package:demo/app/modules/settings/presenter/widgets/settings_tile.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LanguageTile extends StatefulWidget {
  const LanguageTile({super.key});

  @override
  State<LanguageTile> createState() => _LanguageTileState();
}

class _LanguageTileState extends State<LanguageTile> {
  @override
  void initState() {
    super.initState();
    getLocale().then((value) => localeState.value = value);
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return SettingsTile(
          icon: Iconsax.language_square_outline,
          trailing: getLocaleFlag(localeState.value.languageCode),
          title: translation().language,
          onTap: () async {
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
                    children: [
                      ListTile(
                        leading: Flag(Flags.united_states_of_america),
                        title: const Text('English'),
                        onTap: () async {
                          await setLocale('en').then((locale) {
                            AppWidget.setLocale(context, locale);
                            localeState.value = locale;
                            Navigator.pop(context);
                          });
                        },
                        trailing: localeState.value.languageCode == 'en'
                            ? const Icon(Icons.check)
                            : null,
                      ),
                      ListTile(
                        leading: Flag(Flags.mexico),
                        title: const Text('Español'),
                        onTap: () async {
                          await setLocale('es').then((locale) {
                            AppWidget.setLocale(context, locale);
                            localeState.value = locale;
                            Navigator.pop(context);
                          });
                        },
                        trailing: localeState.value.languageCode == 'es'
                            ? const Icon(Icons.check)
                            : null,
                      ),
                      ListTile(
                        leading: Flag(Flags.brazil),
                        title: const Text('Português'),
                        onTap: () async {
                          await setLocale('pt').then((locale) {
                            AppWidget.setLocale(context, locale);
                            localeState.value = locale;
                            Navigator.pop(context);
                          });
                        },
                        trailing: localeState.value.languageCode == 'pt'
                            ? const Icon(Icons.check)
                            : null,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
