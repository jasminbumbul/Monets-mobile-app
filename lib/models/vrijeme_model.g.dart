// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vrijeme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VrijemeModel _$VrijemeModelFromJson(Map<String, dynamic> json) => VrijemeModel(
      json['vrijeme'] == null
          ? null
          : DateTime.parse(json['vrijeme'] as String),
      json['isSlobodno'] as bool?,
    );

Map<String, dynamic> _$VrijemeModelToJson(VrijemeModel instance) =>
    <String, dynamic>{
      'vrijeme': instance.vrijeme?.toIso8601String(),
      'isSlobodno': instance.isSlobodno,
    };
