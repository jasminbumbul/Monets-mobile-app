// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaModel _$RezervacijaModelFromJson(Map<String, dynamic> json) =>
    RezervacijaModel(
      json['rezervacijaId'] as int?,
      json['stolId'] as int?,
      json['klijentId'] as int?,
      json['sifra'] as String?,
      json['poruka'] as String?,
      json['potvrdjena'] as bool?,
      json['potvrdjenaKlijent'] as bool?,
      json['placena'] as bool?,
      json['status'] as bool?,
      json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
      json['datumIzmjene'] == null
          ? null
          : DateTime.parse(json['datumIzmjene'] as String),
      json['pocetakRezervacije'] == null
          ? null
          : DateTime.parse(json['pocetakRezervacije'] as String),
      json['krajRezervacije'] == null
          ? null
          : DateTime.parse(json['krajRezervacije'] as String),
    )..onlinePlacanje = json['onlinePlacanje'] as bool?;

Map<String, dynamic> _$RezervacijaModelToJson(RezervacijaModel instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'stolId': instance.stolId,
      'klijentId': instance.klijentId,
      'sifra': instance.sifra,
      'poruka': instance.poruka,
      'potvrdjena': instance.potvrdjena,
      'potvrdjenaKlijent': instance.potvrdjenaKlijent,
      'placena': instance.placena,
      'status': instance.status,
      'onlinePlacanje': instance.onlinePlacanje,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
      'datumIzmjene': instance.datumIzmjene?.toIso8601String(),
      'pocetakRezervacije': instance.pocetakRezervacije?.toIso8601String(),
      'krajRezervacije': instance.krajRezervacije?.toIso8601String(),
    };
