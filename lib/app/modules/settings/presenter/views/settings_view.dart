import 'package:demo/app/modules/settings/presenter/components/profile_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/dark_mode_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/notification_tile.dart';
import 'package:demo/app/modules/settings/presenter/widgets/settings_tile.dart';
import 'package:demo/core/common/widgets/settings/flex_scheme_selector.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: context.height * 0.05,
            ),
            child: Column(
              children: [
                SimpleText(
                  alignment: Alignment.centerLeft,
                  text: 'Settings',
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
                SettingsTile(
                  icon: Iconsax.profile_circle_outline,
                  title: 'User Profile',
                  onTap: () {},
                ),
                SettingsTile(
                  icon: Iconsax.password_check_outline,
                  title: 'Change Password',
                  onTap: () {},
                ),
                SettingsTile(
                  icon: Iconsax.color_swatch_outline,
                  title: 'Theme Color',
                  onTap: () {
                    flexSchemeSelector(context);
                  },
                ),
                const NotificationTile(),
                const DarkModeTile(),
                Container(
                  margin: EdgeInsets.only(top: context.height * 0.04),
                  child: Card(
                    elevation: 4,
                    color: context.theme.cardColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SimpleText(
                            maxlines: 3,
                            fontSize: 16,
                            textAlign: TextAlign.center,
                            mgBottom: context.height * 0.03,
                            text: 'If you have other query you can reach'
                                ' out to us.',
                          ),
                          Ink(
                            child: InkWell(
                              child: SimpleText(
                                text: 'Whatsapp Us',
                                color: context.theme.primaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
