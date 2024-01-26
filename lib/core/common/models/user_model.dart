import 'dart:convert';

import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/core/common/entities/user.dart';
import 'package:demo/core/common/enums/user_type.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.userType,
    required super.firebaseIds,
    super.email,
    super.profilePicture,
    super.bio,
    super.fcmToken,
  });

  factory UserModel.fromMap(DataMap map, {String? id}) {
    return UserModel(
      id: id ?? ((map['id'] as String?) ?? ''),
      name: (map['name'] as String?) ?? '',
      userType: map['userType'] != null
          ? UserType.fromString(map['userType'] as String)
          : UserType.unknown,
      firebaseIds: List<String>.from(
        (map['firebaseIds'] as List<dynamic>?) ?? const [],
      ),
      email: (map['email'] as String?) ?? '',
      profilePicture: (map['profilePicture'] as String?) ?? '',
      bio: (map['bio'] as String?) ?? '',
      fcmToken: (map['fcmToken'] as String?) ?? '',
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      name: '',
      userType: UserType.unknown,
      firebaseIds: <String>[],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    UserType? userType,
    List<String>? firebaseIds,
    String? email,
    String? profilePicture,
    String? bio,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      firebaseIds: firebaseIds ?? this.firebaseIds,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'userType': userType.name,
        'firebaseIds': firebaseIds,
        'email': email,
        'profilePicture': profilePicture,
        'bio': bio,
        'fcmToken': fcmToken,
      };

  String toJson() => json.encode(toMap());
}
