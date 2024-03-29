import 'package:demo/app/modules/profile/presenter/views/profile_view.dart';
import 'package:demo/app/modules/settings/presenter/components/change_password_tile.dart';
import 'package:demo/app/modules/settings/presenter/components/profile_tile.dart';
import 'package:demo/app/modules/settings/presenter/components/whatsapp_us.dart';
import 'package:demo/app/modules/settings/presenter/widgets/dark_mode_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/language_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/notification_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/settings_tile.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/widgets/settings/flex_scheme_selector.dart';
import 'package:demo/core/common/widgets/settings/font_selector.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: context.height * 0.05,
            bottom: context.height * 0.1,
          ),
          child: Column(
            children: [
              SimpleText(
                alignment: Alignment.centerLeft,
                text: translation().settings,
                fontWeight: FontWeight.w600,
                fontSize: 30,
                mgBottom: context.height * 0.03,
              ),
              const ProfileTile(),
              Container(
                margin: EdgeInsets.only(top: context.height * 0.04),
                child: Divider(
                  color: context.theme.disabledColor,
                  indent: 10,
                  endIndent: 10,
                  height: 1,
                ),
              ),
              if (!UserHelper.isAnonymous())
                SettingsTile(
                  icon: Iconsax.profile_circle_outline,
                  title: translation().userProfile,
                  onTap: () {
                    Modular.to.push(CoreUtils.push<void>(const ProfileView()));
                  },
                ),
              if (UserHelper.authMethod() == AuthMethodType.email)
                const ChangePasswordTile(),
              SettingsTile(
                icon: Iconsax.color_swatch_outline,
                title: translation().themeColor,
                onTap: flexSchemeSelector,
              ),
              SettingsTile(
                icon: Iconsax.text_outline,
                title: translation().font,
                onTap: fontSelector,
              ),
              const LanguageTile(),
              if (!UserHelper.isAnonymous()) const NotificationTile(),
              const DarkModeTile(),
              const WhatsappUs(),
            ],
          ),
        ),
      ),
    );
  }
}
