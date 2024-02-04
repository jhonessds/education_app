import 'dart:convert';

import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/auth_method_type.dart';
import 'package:demo/core/common/enums/gender_type.dart';
import 'package:demo/core/common/enums/user_type.dart';
import 'package:demo/core/utils/typedefs.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.userType,
    required super.authMethod,
    super.profilePicture,
    super.gender,
    super.bio,
    super.fcmToken,
    super.firstAccess,
    super.verified,
  });

  factory UserModel.fromMap(DataMap map, {String? id}) {
    return UserModel(
      id: id ?? ((map['id'] as String?) ?? ''),
      name: (map['name'] as String?) ?? '',
      userType: map['userType'] != null
          ? UserType.fromString(map['userType'] as String)
          : UserType.anonymous,
      gender: map['gender'] != null
          ? GenderType.fromString(map['userType'] as String)
          : GenderType.male,
      authMethod: map['authMethod'] != null
          ? AuthMethodType.fromString(map['authMethod'] as String)
          : AuthMethodType.anonymous,
      email: (map['email'] as String?) ?? '',
      profilePicture: (map['profilePicture'] as String?) ?? '',
      bio: (map['bio'] as String?) ?? '',
      fcmToken: (map['fcmToken'] as String?) ?? '',
      firstAccess: map['firstAccess'] as bool,
      verified: map['verified'] as bool,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      name: '',
      email: '',
      userType: UserType.anonymous,
      authMethod: AuthMethodType.anonymous,
    );
  }

  UserModel copyWith({
    String? id,
    String? firebaseId,
    String? name,
    UserType? userType,
    AuthMethodType? authMethod,
    GenderType? gender,
    String? email,
    String? profilePicture,
    String? bio,
    String? fcmToken,
    bool? firstAccess,
    bool? verified,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      authMethod: authMethod ?? this.authMethod,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
      fcmToken: fcmToken ?? this.fcmToken,
      firstAccess: firstAccess ?? this.firstAccess,
      verified: verified ?? this.verified,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'userType': userType.name,
        'authMethod': authMethod.name,
        'gender': gender.name,
        'profilePicture': profilePicture,
        'bio': bio,
        'fcmToken': fcmToken,
        'firstAccess': firstAccess,
        'verified': verified,
      };

  DataMap toDeleteMap() => {
        'id': id,
        'userType': userType.name,
        'authMethod': authMethod.name,
        'gender': gender.name,
      };

  String toJson() => json.encode(toMap());
}
