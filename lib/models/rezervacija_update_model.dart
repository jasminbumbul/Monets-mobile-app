import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_update_model.g.dart';

@JsonSerializable()
class RezervacijaUpdateModel{
  final DateTime? pocetakRezervacije, krajRezervacije;
  final bool? placena, potvrdjena, potvrdjenaKlijent, status;
  final String? poruka;
  int? stolId, klijentId;


  RezervacijaUpdateModel(
      this.pocetakRezervacije,
      this.krajRezervacije,
      this.placena,
      this.potvrdjena,
      this.potvrdjenaKlijent,
      this.status,
      this.poruka,
      this.stolId);

  factory RezervacijaUpdateModel.fromJson(Map<String, dynamic> json)=> _$RezervacijaUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaUpdateModelToJson(this);
}