import 'package:json_annotation/json_annotation.dart';

part 'rezervacija_model.g.dart';

@JsonSerializable()
class RezervacijaModel {
  int? rezervacijaId, stolId, klijentId;
  String? sifra, poruka;
  bool? potvrdjena, potvrdjenaKlijent, placena, status, onlinePlacanje;
  DateTime? datumKreiranja, datumIzmjene, pocetakRezervacije, krajRezervacije;

  RezervacijaModel(
      this.rezervacijaId,
      this.stolId,
      this.klijentId,
      this.sifra,
      this.poruka,
      this.potvrdjena,
      this.potvrdjenaKlijent,
      this.placena,
      this.status,
      this.datumKreiranja,
      this.datumIzmjene,
      this.pocetakRezervacije,
      this.krajRezervacije);

  RezervacijaModel.dropdown (this.rezervacijaId, this.sifra);

  factory RezervacijaModel.fromJson(Map<String, dynamic> json) =>
      _$RezervacijaModelFromJson(json);

  Map<String, dynamic> toJson() => _$RezervacijaModelToJson(this);
}
