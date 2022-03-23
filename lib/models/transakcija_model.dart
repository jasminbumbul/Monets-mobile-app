import 'package:json_annotation/json_annotation.dart';

part 'transakcija_model.g.dart';

@JsonSerializable()
class TransakcijaModel{
  late int transakcijaId, rezervacijaId, korisnikId;
  late String sifra;

  TransakcijaModel(
      this.transakcijaId, this.rezervacijaId, this.korisnikId, this.sifra);

  factory TransakcijaModel.fromJson(Map<String, dynamic> json) => _$TransakcijaModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransakcijaModelToJson(this);
}