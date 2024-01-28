import 'package:demo/app/modules/auth/presentation/controllers/session_controller.dart';
import 'package:demo/app/modules/register/domain/usecases/register_user.dart';
import 'package:demo/app/modules/register/domain/usecases/register_user_by_email.dart';
import 'package:demo/core/abstraction/either.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:demo/core/common/models/user_model.dart';
import 'package:demo/core/errors/failure.dart';
import 'package:demo/core/services/preferences/language_constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_auth;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';

class RegisterController {
  RegisterController({
    required f_auth.FirebaseAuth firebaseAuth,
    required RegisterUser registerUser,
    required RegisterUserByEmail registerUserByEmail,
  })  : _firebaseAuth = firebaseAuth,
        _registerUser = registerUser,
        _registerUserByEmail = registerUserByEmail;

  final f_auth.FirebaseAuth _firebaseAuth;
  final RegisterUser _registerUser;
  final RegisterUserByEmail _registerUserByEmail;

  AuthMethodType authType = AuthMethodType.email;
  String name = '';
  String email = '';
  String password = '';
  String errorMessage = '';

  Future<bool> registerLoggedUser() async {
    Either<Failure, User> result;

    if (authType != AuthMethodType.email) {
      final userToInsert = _userFormatedToInsert(
        profilePictureParam: _firebaseAuth.currentUser!.photoURL,
        emailParam: _firebaseAuth.currentUser!.email,
        loginParam: List.filled(1, _firebaseAuth.currentUser!.uid),
      );
      result = await _registerUser(userToInsert);
    } else {
      final userToInsert = _userFormatedToInsert();
      result = await _registerUserByEmail(
        RegisterParams(
          user: userToInsert,
          email: email,
          password: password,
        ),
      );
    }

    return _processResult(result);
  }

  Future<bool> _processResult(Either<Failure, User> result) async {
    return result.fold(
      (l) {
        errorMessage = l.message ?? translation().problemWithRequest;
        return false;
      },
      (user) async {
        await Modular.get<SessionController>().setLoggedUser(user as UserModel);
        return true;
      },
    );
  }

  UserModel _userFormatedToInsert({
    String? nameParam,
    String? profilePictureParam,
    String? emailParam,
    UserType? userTypeParam,
    List<String>? loginParam,
  }) {
    final uuid = const Uuid().v4();
    return UserModel(
      id: uuid,
      name: nameParam ?? name,
      email: emailParam ?? email,
      profilePicture: profilePictureParam,
      firebaseIds: loginParam ?? List.empty(),
      userType: userTypeParam ?? UserType.common,
    );
  }
}
