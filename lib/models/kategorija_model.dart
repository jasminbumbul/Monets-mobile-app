import 'package:json_annotation/json_annotation.dart';

part 'kategorija_model.g.dart';

@JsonSerializable()
class KategorijaModel{
  final int kategorijaId;
  final String? naziv, slika;

  KategorijaModel(this.kategorijaId, this.naziv, this.slika);

  factory KategorijaModel.fromJson(Map<String,dynamic> json) => _$KategorijaModelFromJson(json);

  Map<String, dynamic> toJson() => _$KategorijaModelToJson(this);
}