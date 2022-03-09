import 'package:json_annotation/json_annotation.dart';
import 'package:monets/models/korisnicki_racun_model.dart';

part 'klijent_model.g.dart';

@JsonSerializable()
class KlijentModel {
  int? klijentId, gradId;
  String? ime, prezime, korisnickoIme, email, telefon, adresa, slika;
  DateTime? datumKreiranja, datumRodjenja;
  bool? status;
  KorisnickiRacunModel? korisnickiRacun;


  KlijentModel.Default();

  KlijentModel(
      this.klijentId,
      this.gradId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.email,
      this.telefon,
      this.adresa,
      this.slika,
      this.datumKreiranja,
      this.datumRodjenja,
      this.status,
      this.korisnickiRacun);

  factory KlijentModel.fromJson(Map<String, dynamic> json) =>
      _$KlijentModelFromJson(json);

  Map<String, dynamic> toJson() => _$KlijentModelToJson(this);
}
