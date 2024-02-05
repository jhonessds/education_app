import 'package:demo/app/modules/profile/presenter/views/profile_view.dart';
import 'package:demo/core/common/actions/app_actions.dart';
import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileHomeTile extends StatelessWidget {
  const ProfileHomeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ProfilePicture(
        mRight: 0,
        size: 50,
        onTap: () {
          if (!UserHelper.isAnonymous()) {
            Modular.to.push(CoreUtils.push(const ProfileView()));
          }
        },
      ),
      title: Text(
        translation().hello,
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
    );
  }
}
