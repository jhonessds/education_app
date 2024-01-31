import 'package:demo/app/modules/settings/presenter/components/change_password_button.dart';
import 'package:demo/app/modules/settings/presenter/components/change_password_form.dart';
import 'package:demo/app/modules/settings/presenter/widgets/settings_tile.dart';
import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ChangePasswordTile extends StatelessWidget {
  const ChangePasswordTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      icon: Iconsax.password_check_outline,
      title: translation().changePassword,
      onTap: () async {
        final formKey = GlobalKey<FormState>();
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          builder: (context) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: context.width * 0.3,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 3,
                  ),
                  SimpleText(
                    mgTop: 10,
                    mgBottom: 20,
                    text: translation().changePassword,
                    fontWeight: FontWeight.w600,
                    color: context.theme.primaryColor,
                    fontSize: 21,
                  ),
                  ChangePasswordForm(
                    formKey: formKey,
                  ),
                  ChangePasswordButton(
                    formKey: formKey,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
