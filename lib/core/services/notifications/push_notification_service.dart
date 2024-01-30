import 'package:demo/core/services/notifications/notification_functions.dart';
import 'package:demo/core/services/notifications/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationsManager {
  factory PushNotificationsManager() => _instance;

  PushNotificationsManager._();
  static final _instance = PushNotificationsManager._();

  final _firebaseMessaging = FirebaseMessaging.instance;
  SharedPreferences? _sharedPreferences;

  bool _initialized = false;

  Future<void> resetClass() async {
    _initialized = false;
    await _sharedPreferences?.remove('isTokenSent');
  }

  Future<void> init({required String userId}) async {
    if (!_initialized) {
      _sharedPreferences = await SharedPreferences.getInstance();
      final settings = await _firebaseMessaging.requestPermission();

      // Com app fechado
      // ignore: unawaited_futures
      _firebaseMessaging.getInitialMessage().then((message) {
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

      final isTokenSent = _sharedPreferences!.getBool('isTokenSent') ?? false;

      if (!isTokenSent) {
        //final token = await _firebaseMessaging.getToken();

        // final result = await SetFcmToken().call(
        //   userId: userId,
        //   fcmToken: token ?? '',
        // );

        // if (result && token != null) {
        //   await _sharedPreferences!.setBool('isTokenSent', true);
        // }
      }

      _initialized = true;
    }
  }

  void _onAppClosedAction(
    NotificationSettings settings,
    RemoteMessage message,
  ) {}
}
