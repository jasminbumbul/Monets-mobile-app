import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_search_model.g.dart';

@JsonSerializable()
class RezervacijaSearchModel{
  final String? sifra;
  final bool? status;
  final int klijentId;
  final bool potvrdjenaKlijent;


  RezervacijaSearchModel(this.sifra, this.status, this.klijentId, this.potvrdjenaKlijent);

  factory RezervacijaSearchModel.fromJson(Map<String, dynamic> json)=> _$RezervacijaSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaSearchModelToJson(this);
}