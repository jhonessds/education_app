import 'package:demo/core/common/widgets/profile/profile_picture.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';

class ProfileHomeTile extends StatelessWidget {
  const ProfileHomeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const ProfilePicture(
        mRight: 0,
        height: 50,
        width: 50,
      ),
      title: Text(
        'Olá',
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
