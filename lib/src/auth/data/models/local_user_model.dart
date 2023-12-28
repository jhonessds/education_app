import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    super.profilePicture,
    super.bio,
    required super.points,
    required super.groupIds,
    required super.fullName,
    required super.enrollCourseIds,
    required super.following,
    required super.followers,
  });

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

  DataMap toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'email': email});
    if (profilePicture != null) {
      result.addAll({'profilePicture': profilePicture});
    }
    if (bio != null) {
      result.addAll({'bio': bio});
    }
    result.addAll({'points': points});
    result.addAll({'fullName': fullName});
    result.addAll({'groupIds': groupIds});
    result.addAll({'enrollCourseIds': enrollCourseIds});
    result.addAll({'following': following});
    result.addAll({'followers': followers});

    return result;
  }

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profilePicture'],
      bio: map['bio'],
      points: map['points']?.toInt() ?? 0,
      fullName: map['fullName'],
      groupIds: List<String>.from(map['groupIds'] ?? const []),
      enrollCourseIds: List<String>.from(map['enrollCourseIds'] ?? const []),
      following: List<String>.from(map['following'] ?? const []),
      followers: List<String>.from(map['followers'] ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUserModel.fromJson(String source) =>
      LocalUserModel.fromMap(json.decode(source));
}
