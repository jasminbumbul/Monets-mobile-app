// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rejting_upsert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejtingUpsertModel _$RejtingUpsertModelFromJson(Map<String, dynamic> json) =>
    RejtingUpsertModel(
      (json['ocjena'] as num?)?.toDouble(),
      json['jeloId'] as int?,
      json['klijentId'] as int?,
    );

Map<String, dynamic> _$RejtingUpsertModelToJson(RejtingUpsertModel instance) =>
    <String, dynamic>{
      'ocjena': instance.ocjena,
      'jeloId': instance.jeloId,
      'klijentId': instance.klijentId,
    };
