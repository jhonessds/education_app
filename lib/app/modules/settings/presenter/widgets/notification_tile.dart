import 'package:asp/asp.dart';
import 'package:demo/app/modules/auth/presenter/controllers/session_controller.dart';
import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/app/modules/settings/presenter/controllers/states/setting_state.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:demo/core/utils/core_utils.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({
    super.key,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  void initState() {
    super.initState();
    fcmTokenState.value = UserHelper.pushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              leading: Icon(
                fcmTokenState.value
                    ? Clarity.notification_outline_badged
                    : Clarity.notification_line,
              ),
              title: Text(
                translation().pushNotification,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Switch(
                value: fcmTokenState.value,
                onChanged: (_) async {
                  final profileCtrl = Modular.get<ProfileController>();
                  final user = Modular.get<SessionController>().currentUser;
                  final sharedPrefs = await SharedPreferences.getInstance();
                  late UserModel userToUpdate;

                  if (fcmTokenState.value) {
                    userToUpdate = user.copyWith(fcmToken: '');
                    await sharedPrefs.setBool('isTokenSent', false);
                    fcmTokenState.value = false;
                  } else {
                    final firebaseMessaging = FirebaseMessaging.instance;
                    final fcmToken = await firebaseMessaging.getToken();
                    userToUpdate = user.copyWith(fcmToken: fcmToken);
                    fcmTokenState.value = true;
                  }

                  final result = await profileCtrl.updateUser(
                    user: userToUpdate,
                  );

                  if (!result) {
                    CoreUtils.bottomSnackBar(profileCtrl.errorMessage);
                  }
                },
              ),
            ),
            Divider(
              color: context.theme.disabledColor,
              indent: 10,
              endIndent: 10,
              height: 5,
            ),
          ],
        );
      },
    );
  }
}
