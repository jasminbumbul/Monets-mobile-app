import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_insert_model.g.dart';

@JsonSerializable()
class RezervacijaInsertModel{
  final DateTime? pocetakRezervacije, krajRezervacije;
  final bool? placena, potvrdjena, potvrdjenaKlijent, onlinePlacanje;
  final String? poruka;
  int? stolId, klijentId;


  RezervacijaInsertModel(
      this.pocetakRezervacije,
      this.krajRezervacije,
      this.placena,
      this.potvrdjena,
      this.potvrdjenaKlijent,
      this.onlinePlacanje,
      this.poruka,
      this.stolId);

  factory RezervacijaInsertModel.fromJson(Map<String, dynamic> json)=> _$RezervacijaInsertModelFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaInsertModelToJson(this);
}