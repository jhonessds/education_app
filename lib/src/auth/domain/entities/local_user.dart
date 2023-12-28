import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  final String uid;
  final String email;
  final String? profilePicture;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrollCourseIds;
  final List<String> following;
  final List<String> followers;

  const LocalUser({
    required this.uid,
    required this.email,
    this.profilePicture,
    this.bio,
    required this.points,
    required this.fullName,
    required this.groupIds,
    required this.enrollCourseIds,
    required this.following,
    required this.followers,
  });

  factory LocalUser.empty() {
    return const LocalUser(
      uid: '',
      email: '',
      points: 0,
      fullName: '',
      groupIds: [],
      enrollCourseIds: [],
      following: [],
      followers: [],
    );
  }

  @override
  List<Object> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser(uid: $uid, email: $email,'
        ' bio: $bio, points: $points, fullName: $fullName)';
  }
}
