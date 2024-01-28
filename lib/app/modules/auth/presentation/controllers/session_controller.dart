import 'package:demo/app/modules/auth/domain/usecases/get_session_user.dart';
import 'package:demo/app/modules/auth/domain/usecases/log_out.dart';
import 'package:demo/core/common/models/user_model.dart';
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

  Future<void> setLoggedUser(UserModel user) async {
    _currentUser = user;
    await UserHelper.setUser(user);
  }

  void setUnloggedUser() => _currentUser = null;

  // Future<void> logOut({
  //   bool popRoute = true,
  //   bool sessionExpired = false,
  // }) async {
  //   //PushNotificationsManager().resetClass();
  //   await _logOut();

  //   UserHelper.removeUser();
  //   setUnloggedUser();
  //   if (popRoute) {
  //     Modular.to.popUntil(ModalRoute.withName('/home/'));
  //     Modular.to.pushReplacementNamed('/home/project-page/');
  //   }
  //   if (sessionExpired) {
  //     showToast(translation().sessionExpired);
  //   }
  // }
}
