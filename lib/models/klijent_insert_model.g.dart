// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'klijent_insert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KlijentInsertModel _$KlijentInsertModelFromJson(Map<String, dynamic> json) =>
    KlijentInsertModel(
      json['gradId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['korisnickoIme'] as String?,
      json['email'] as String?,
      json['telefon'] as String?,
      json['adresa'] as String?,
      json['slika'] as String?,
      json['lozinka'] as String?,
      json['lozinkaPotvrda'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['status'] as bool?,
    );

Map<String, dynamic> _$KlijentInsertModelToJson(KlijentInsertModel instance) =>
    <String, dynamic>{
      'gradId': instance.gradId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'telefon': instance.telefon,
      'adresa': instance.adresa,
      'slika': instance.slika,
      'lozinka': instance.lozinka,
      'lozinkaPotvrda': instance.lozinkaPotvrda,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'status': instance.status,
    };
