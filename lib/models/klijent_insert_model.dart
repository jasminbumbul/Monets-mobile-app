import 'package:json_annotation/json_annotation.dart';

part 'klijent_insert_model.g.dart';

@JsonSerializable()
class KlijentInsertModel{
  int? gradId;
  String? ime, prezime, korisnickoIme, email, telefon, adresa, slika, lozinka, lozinkaPotvrda;
  DateTime? datumRodjenja;
  bool? status;

  KlijentInsertModel(
      this.gradId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.email,
      this.telefon,
      this.adresa,
      this.slika,
      this.lozinka,
      this.lozinkaPotvrda,
      this.datumRodjenja,
      this.status);

  KlijentInsertModel.withoutPassword(
      this.gradId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.email,
      this.telefon,
      this.adresa,
      this.slika,
      this.datumRodjenja,
      this.status);

  factory KlijentInsertModel.fromJson(Map<String, dynamic> json) => _$KlijentInsertModelFromJson(json);

  Map<String, dynamic> toJson() => _$KlijentInsertModelToJson(this);

}