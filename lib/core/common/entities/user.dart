import 'package:demo/core/common/enums/user_type.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.userType,
    required this.firebaseIds,
    this.email,
    this.profilePicture,
    this.bio,
    this.fcmToken,
  });

  final String id;
  final String name;
  final UserType userType;
  final List<String> firebaseIds;
  final String? email;
  final String? profilePicture;
  final String? bio;
  final String? fcmToken;

  @override
  List<Object> get props => [id, name];
}
