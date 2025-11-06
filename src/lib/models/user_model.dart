import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Defines the fixed user roles in the system.
enum UserRole {
  @JsonValue('student')
  student,
  @JsonValue('parent')
  parent,
  @JsonValue('admin')
  admin,
}

/// The main User data model.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    required UserRole role,
    @Default('') String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
