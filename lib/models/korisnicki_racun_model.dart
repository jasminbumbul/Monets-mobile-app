import 'package:json_annotation/json_annotation.dart';

part 'korisnicki_racun_model.g.dart';

@JsonSerializable()
class KorisnickiRacunModel{
  final bool emailVerified;

  KorisnickiRacunModel(this.emailVerified);

  factory KorisnickiRacunModel.fromJson(Map<String, dynamic> json) => _$KorisnickiRacunModelFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnickiRacunModelToJson(this);
}