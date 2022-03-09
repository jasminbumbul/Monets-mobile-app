// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jelo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JeloModel _$JeloModelFromJson(Map<String, dynamic> json) => JeloModel(
      json['jeloId'] as int?,
      json['vrijemeIzradeUminutama'] as int?,
      json['nazivJela'] as String?,
      json['slika'] as String?,
      json['opisJela'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['status'] as bool?,
    );

Map<String, dynamic> _$JeloModelToJson(JeloModel instance) => <String, dynamic>{
      'jeloId': instance.jeloId,
      'vrijemeIzradeUminutama': instance.vrijemeIzradeUminutama,
      'nazivJela': instance.nazivJela,
      'slika': instance.slika,
      'opisJela': instance.opisJela,
      'cijena': instance.cijena,
      'status': instance.status,
    };
