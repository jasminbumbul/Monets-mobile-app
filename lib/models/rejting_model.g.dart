// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejtingModel _$RejtingModelFromJson(Map<String, dynamic> json) => RejtingModel(
      (json['ocjena'] as num?)?.toDouble(),
      json['jeloId'] as int?,
      json['klijentId'] as int?,
      json['rejtingId'] as int?,
    );

Map<String, dynamic> _$RejtingModelToJson(RejtingModel instance) =>
    <String, dynamic>{
      'ocjena': instance.ocjena,
      'jeloId': instance.jeloId,
      'klijentId': instance.klijentId,
      'rejtingId': instance.rejtingId,
    };
