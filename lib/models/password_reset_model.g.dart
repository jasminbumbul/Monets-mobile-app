// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetModel _$PasswordResetModelFromJson(Map<String, dynamic> json) =>
    PasswordResetModel(
      json['email'] as String,
      json['password'] as String,
      json['passwordRepeat'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$PasswordResetModelToJson(PasswordResetModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'passwordRepeat': instance.passwordRepeat,
      'code': instance.code,
    };
