import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    this.profilePicture,
    this.bio,
    this.points = 0,
    this.groupIds = const [],
    this.enrollCourseIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  factory LocalUser.empty() {
    return const LocalUser(uid: '', email: '', fullName: '');
  }

  final String uid;
  final String email;
  final String fullName;
  final int points;
  final String? profilePicture;
  final String? bio;
  final List<String> groupIds;
  final List<String> enrollCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object> get props => [uid, email];
}
