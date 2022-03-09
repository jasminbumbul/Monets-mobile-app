// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaUpdateModel _$RezervacijaUpdateModelFromJson(
        Map<String, dynamic> json) =>
    RezervacijaUpdateModel(
      json['pocetakRezervacije'] == null
          ? null
          : DateTime.parse(json['pocetakRezervacije'] as String),
      json['krajRezervacije'] == null
          ? null
          : DateTime.parse(json['krajRezervacije'] as String),
      json['placena'] as bool?,
      json['potvrdjena'] as bool?,
      json['potvrdjenaKlijent'] as bool?,
      json['poruka'] as String?,
      json['stolId'] as int?,
    )..klijentId = json['klijentId'] as int?;

Map<String, dynamic> _$RezervacijaUpdateModelToJson(
        RezervacijaUpdateModel instance) =>
    <String, dynamic>{
      'pocetakRezervacije': instance.pocetakRezervacije?.toIso8601String(),
      'krajRezervacije': instance.krajRezervacije?.toIso8601String(),
      'placena': instance.placena,
      'potvrdjena': instance.potvrdjena,
      'potvrdjenaKlijent': instance.potvrdjenaKlijent,
      'poruka': instance.poruka,
      'stolId': instance.stolId,
      'klijentId': instance.klijentId,
    };
