// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransakcijaModel _$TransakcijaModelFromJson(Map<String, dynamic> json) =>
    TransakcijaModel(
      json['transakcijaId'] as int,
      json['rezervacijaId'] as int,
      json['korisnikId'] as int,
      json['sifra'] as String,
    );

Map<String, dynamic> _$TransakcijaModelToJson(TransakcijaModel instance) =>
    <String, dynamic>{
      'transakcijaId': instance.transakcijaId,
      'rezervacijaId': instance.rezervacijaId,
      'korisnikId': instance.korisnikId,
      'sifra': instance.sifra,
    };
