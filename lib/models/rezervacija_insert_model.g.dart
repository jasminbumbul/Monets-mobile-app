// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_insert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaInsertModel _$RezervacijaInsertModelFromJson(
        Map<String, dynamic> json) =>
    RezervacijaInsertModel(
      json['pocetakRezervacije'] == null
          ? null
          : DateTime.parse(json['pocetakRezervacije'] as String),
      json['krajRezervacije'] == null
          ? null
          : DateTime.parse(json['krajRezervacije'] as String),
      json['placena'] as bool?,
      json['potvrdjena'] as bool?,
      json['potvrdjenaKlijent'] as bool?,
      json['onlinePlacanje'] as bool?,
      json['poruka'] as String?,
      json['stolId'] as int?,
    )..klijentId = json['klijentId'] as int?;

Map<String, dynamic> _$RezervacijaInsertModelToJson(
        RezervacijaInsertModel instance) =>
    <String, dynamic>{
      'pocetakRezervacije': instance.pocetakRezervacije?.toIso8601String(),
      'krajRezervacije': instance.krajRezervacije?.toIso8601String(),
      'placena': instance.placena,
      'potvrdjena': instance.potvrdjena,
      'potvrdjenaKlijent': instance.potvrdjenaKlijent,
      'onlinePlacanje': instance.onlinePlacanje,
      'poruka': instance.poruka,
      'stolId': instance.stolId,
      'klijentId': instance.klijentId,
    };
