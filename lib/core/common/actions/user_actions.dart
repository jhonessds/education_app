import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/common/states/user_state.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';

Future<void> setLoggedUser(UserModel user) async {
  currentUserState.value = user;
  await UserHelper.setUser(user);
}

void setUnloggedUser() => currentUserState.value = UserModel.empty();
