import 'package:asp/asp.dart';

import 'package:demo/app/modules/settings/presenter/widgets/settings_tile.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/states/app_state.dart';
import 'package:demo/core/common/widgets/settings/language_selector.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return SettingsTile(
          icon: Iconsax.language_square_outline,
          trailing: getLocaleFlag(
            appConfigState.value.language.locale,
          ),
          title: translation().language,
          onTap: () async => languageSelector(),
        );
      },
    );
  }
}
