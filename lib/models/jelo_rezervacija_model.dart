import 'package:json_annotation/json_annotation.dart';

part 'jelo_rezervacija_model.g.dart';

@JsonSerializable()
class JeloRezervacijaModel{
  int? jeloId, rezervacijaId, kolicina;

  JeloRezervacijaModel(this.jeloId, this.rezervacijaId, this.kolicina);

  JeloRezervacijaModel.setJelo(this.jeloId);

  JeloRezervacijaModel.setKolicinu(this.kolicina);

  JeloRezervacijaModel.setJeloKolicinu(this.jeloId, this.kolicina);

  factory JeloRezervacijaModel.fromJson(Map<String, dynamic> json)=> _$JeloRezervacijaModelFromJson(json);

  Map<String, dynamic> toJson() => _$JeloRezervacijaModelToJson(this);
}