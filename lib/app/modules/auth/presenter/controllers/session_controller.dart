import 'package:demo/app/modules/auth/domain/usecases/get_session_user.dart';
import 'package:demo/app/modules/auth/domain/usecases/log_out.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/services/notifications/push_notification_service.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';

class SessionController {
  SessionController(
    this._logOut,
    this._getSessionUser,
  );

  final LogOut _logOut;
  final GetSessionUser _getSessionUser;

  UserModel? _currentUser;
  UserModel get currentUser => _currentUser!;
  bool get hasCurrentUser => _currentUser != null;

  Future<void> setLoggedUser(UserModel user) async {
    _currentUser = user;
    await UserHelper.setUser(user);
  }

  void setUnloggedUser() => _currentUser = null;

  Future<bool> getSessionUser() async {
    final result = await _getSessionUser();

    return result.fold(
      (l) => false,
      (user) async {
        if (user != null) {
          await setLoggedUser(user as UserModel);
          return true;
        }
        return false;
      },
    );
  }

  Future<void> logOut() async {
    await PushNotificationsManager().resetClass();
    await UserHelper.removeUser();
    setUnloggedUser();
    await _logOut();
  }
}
