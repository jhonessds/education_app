import 'dart:convert';

import 'package:demo/core/utils/typedefs.dart';
import 'package:demo/src/auth/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.profilePicture,
    super.bio,
    super.points,
    super.groupIds,
    super.enrollCourseIds,
    super.following,
    super.followers,
  });

  factory LocalUserModel.fromMap(DataMap map, {String? uid}) {
    return LocalUserModel(
      uid: uid ?? ((map['uid'] as String?) ?? ''),
      email: (map['email'] as String?) ?? '',
      profilePicture: (map['profilePicture'] as String?) ?? '',
      bio: (map['bio'] as String?) ?? '',
      points: map['points'] != null ? (map['points'] as num).toInt() : 0,
      fullName: (map['fullName'] as String?) ?? '',
      groupIds:
          List<String>.from((map['groupIds'] as List<dynamic>?) ?? const []),
      enrollCourseIds: List<String>.from(
        (map['enrollCourseIds'] as List<dynamic>?) ?? const [],
      ),
      following:
          List<String>.from((map['following'] as List<dynamic>?) ?? const []),
      followers:
          List<String>.from((map['followers'] as List<dynamic>?) ?? const []),
    );
  }

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory LocalUserModel.empty() {
    return const LocalUserModel(uid: '', email: '', fullName: '');
  }

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? profilePicture,
    String? bio,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrollCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrollCourseIds: enrollCourseIds ?? this.enrollCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'profilePicture': profilePicture,
        'bio': bio,
        'points': points,
        'fullName': fullName,
        'groupIds': groupIds,
        'enrollCourseIds': enrollCourseIds,
        'following': following,
        'followers': followers,
      };

  DataMap toInsertMap() => {
        'uid': uid,
        'email': email,
        'profilePicture': profilePicture,
        'fullName': fullName,
      };

  String toJson() => json.encode(toMap());
}
