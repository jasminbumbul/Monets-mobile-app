import 'package:json_annotation/json_annotation.dart';

part 'password_reset_model.g.dart';

@JsonSerializable()
class PasswordResetModel{
  final String email, password, passwordRepeat, code;

  PasswordResetModel(this.email, this.password, this.passwordRepeat, this.code);

  factory PasswordResetModel.fromJson(Map<String, dynamic> json)=> _$PasswordResetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResetModelToJson(this);
}