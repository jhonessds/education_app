import 'dart:math' as math;

import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/widgets/loading_modal.dart';
import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const ProfilePicture(
        mRight: 0,
        size: 50,
      ),
      title: Text(
        UserHelper.gender() == GenderType.male
            ? translation().welcomeM
            : translation().welcomeF,
        style: TextStyle(
          fontSize: 12,
          color: context.theme.disabledColor,
        ),
      ),
      subtitle: Text(
        UserHelper.name(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: context.theme.colorScheme.onBackground,
        ),
      ),
      trailing: IconButton(
        splashRadius: 25,
        onPressed: () async {
          CoreUtils.popAnimated(
            'exit_app',
            text: 'Deseja se desconectar?',
            showOkBtn: false,
            repeat: true,
            callback: () async {
              loadingWidget();
              if (UserHelper.isAnonymous()) {
                await Modular.get<ProfileController>().deleteUser(
                  userId: UserHelper.id(),
                );
              }
              await Modular.get<SessionController>().logOut();
              Modular.to.pop();
              await Modular.to.pushReplacementNamed('/auth/');
            },
          );
        },
        icon: Transform.rotate(
          angle: 180 * math.pi / 180,
          child: Icon(
            Iconsax.logout_outline,
            color: context.theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
