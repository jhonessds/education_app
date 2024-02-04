import 'package:demo/app/modules/profile/presenter/controllers/profile_controller.dart';
import 'package:demo/app/modules/settings/presenter/controllers/states/setting_state.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/services/notifications/notification_functions.dart';
import 'package:demo/core/services/notifications/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsManager {
  factory PushNotificationsManager() => _instance;

  PushNotificationsManager._();
  static final _instance = PushNotificationsManager._();
  SharedPreferences? _prefs;

  bool _initialized = false;

  Future<void> resetClass() async {
    _initialized = false;
    await _prefs?.remove('isTokenSent');
  }

  Future<void> init() async {
    if (!_initialized) {
      final firebaseMessaging = Modular.get<FirebaseMessaging>();
      _prefs = await SharedPreferences.getInstance();
      final settings = await firebaseMessaging.requestPermission();

      // Com app fechado
      await firebaseMessaging.getInitialMessage().then((message) {
        if (message == null) return;
        _onAppClosedAction(settings, message);
      });

      // Com app segundo plano
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        _onAppClosedAction(settings, message);
      });

      // Com app aberto
      FirebaseMessaging.onMessage.listen((message) async {
        if (message.notification == null) return;
        final notification = NotificationModel(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        await showNotificationAlert(notification);
      });

      final isTokenSent = _prefs!.getBool('isTokenSent') ?? false;

      if (!isTokenSent) {
        final profileCtrl = Modular.get<ProfileController>();
        final fcmToken = await firebaseMessaging.getToken();
        if (fcmToken != null) {
          fcmTokenState.value = true;
          await profileCtrl.updateFcmToken(fcmToken: fcmToken);
        }
      }

      _initialized = true;
    }
  }

  void _onAppClosedAction(
    NotificationSettings settings,
    RemoteMessage message,
  ) {}
}
