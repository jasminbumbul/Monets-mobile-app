// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritModel _$FavoritModelFromJson(Map<String, dynamic> json) => FavoritModel(
      json['favoritId'] as int?,
      json['jeloId'] as int?,
      json['klijentId'] as int?,
    );

Map<String, dynamic> _$FavoritModelToJson(FavoritModel instance) =>
    <String, dynamic>{
      'favoritId': instance.favoritId,
      'jeloId': instance.jeloId,
      'klijentId': instance.klijentId,
    };
