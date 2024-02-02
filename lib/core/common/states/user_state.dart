import 'package:asp/asp.dart';
import 'package:demo/core/common/models/user_model.dart';

Atom<UserModel> currentUserState = Atom<UserModel>(UserModel.empty());

bool get hasCurrentUser => currentUserState.value.id.isNotEmpty;
