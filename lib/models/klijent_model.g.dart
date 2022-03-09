// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'klijent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KlijentModel _$KlijentModelFromJson(Map<String, dynamic> json) => KlijentModel(
      json['klijentId'] as int?,
      json['gradId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnickoIme'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['adresa'] as String?,
      json['slika'] as String?,
      json['datumKreiranja'] == null
          ? null
          : DateTime.parse(json['datumKreiranja'] as String),
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['status'] as bool?,
      json['korisnickiRacun'] == null
          ? null
          : KorisnickiRacunModel.fromJson(
              json['korisnickiRacun'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KlijentModelToJson(KlijentModel instance) =>
    <String, dynamic>{
      'klijentId': instance.klijentId,
      'gradId': instance.gradId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'telefon': instance.telefon,
      'adresa': instance.adresa,
      'slika': instance.slika,
      'datumKreiranja': instance.datumKreiranja?.toIso8601String(),
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'status': instance.status,
      'korisnickiRacun': instance.korisnickiRacun,
    };
