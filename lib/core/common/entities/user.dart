import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.userType,
    required this.authMethod,
    required this.email,
    this.profilePicture = '',
    this.gender = GenderType.male,
    this.firstAccess = true,
    this.verified = false,
    this.bio,
    this.fcmToken,
  });

  final String id;

  final String name;
  final UserType userType;
  final AuthMethodType authMethod;
  final GenderType gender;
  final String email;
  final String profilePicture;
  final String? bio;
  final String? fcmToken;
  final bool firstAccess;
  final bool verified;

  @override
  List<Object> get props => [id, name];
}
