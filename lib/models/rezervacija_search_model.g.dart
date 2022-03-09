// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacija_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijaSearchModel _$RezervacijaSearchModelFromJson(
        Map<String, dynamic> json) =>
    RezervacijaSearchModel(
      json['sifra'] as String?,
      json['status'] as bool?,
      json['klijentId'] as int,
      json['potvrdjenaKlijent'] as bool,
    );

Map<String, dynamic> _$RezervacijaSearchModelToJson(
        RezervacijaSearchModel instance) =>
    <String, dynamic>{
      'sifra': instance.sifra,
      'status': instance.status,
      'klijentId': instance.klijentId,
      'potvrdjenaKlijent': instance.potvrdjenaKlijent,
    };
