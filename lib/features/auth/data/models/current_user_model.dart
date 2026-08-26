import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current_user_model.g.dart';

@JsonSerializable()
class CurrentUserModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  const CurrentUserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserModelToJson(this);

  AuthUser toEntity({
    required String accessToken,
    required String refreshToken,
  }) {
    return AuthUser(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
