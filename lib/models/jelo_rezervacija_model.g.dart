// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jelo_rezervacija_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JeloRezervacijaModel _$JeloRezervacijaModelFromJson(
        Map<String, dynamic> json) =>
    JeloRezervacijaModel(
      json['jeloId'] as int?,
      json['rezervacijaId'] as int?,
      json['kolicina'] as int?,
    );

Map<String, dynamic> _$JeloRezervacijaModelToJson(
        JeloRezervacijaModel instance) =>
    <String, dynamic>{
      'jeloId': instance.jeloId,
      'rezervacijaId': instance.rezervacijaId,
      'kolicina': instance.kolicina,
    };
