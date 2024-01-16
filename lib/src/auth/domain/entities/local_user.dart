import 'package:equatable/equatable.dart';

import 'package:objectbox/objectbox.dart';

@Entity()
class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    this.id = 0,
    this.profilePicture,
    this.bio,
    this.points = 0,
    this.groupIds = const [],
    this.enrollCourseIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  set id(int value) {
    if (id != value) id = value;
  }

  final int id;
  final String uid;
  final String email;
  final String fullName;
  final int points;
  final String? profilePicture;
  final String? bio;
  @Transient()
  final List<String> groupIds;
  @Transient()
  final List<String> enrollCourseIds;
  @Transient()
  final List<String> following;
  @Transient()
  final List<String> followers;

  @override
  List<Object> get props => [id, uid, email];
}
