// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorija_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijaModel _$KategorijaModelFromJson(Map<String, dynamic> json) =>
    KategorijaModel(
      json['kategorijaId'] as int?,
      json['naziv'] as String?,
      json['slika'] as String?,
    );

Map<String, dynamic> _$KategorijaModelToJson(KategorijaModel instance) =>
    <String, dynamic>{
      'kategorijaId': instance.kategorijaId,
      'naziv': instance.naziv,
      'slika': instance.slika,
    };
