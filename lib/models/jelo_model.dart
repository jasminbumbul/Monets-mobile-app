import 'package:json_annotation/json_annotation.dart';
import 'package:monets/models/jelo_rezervacija_model.dart';

part 'jelo_model.g.dart';

@JsonSerializable()
class JeloModel{
  final int? jeloId, vrijemeIzradeUminutama;
  final String? nazivJela, slika, opisJela;
  final double? cijena;
  final bool? status;


  JeloModel(this.jeloId, this.vrijemeIzradeUminutama, this.nazivJela,
      this.slika, this.opisJela, this.cijena, this.status);

  factory JeloModel.fromJson(Map<String,dynamic> json) => _$JeloModelFromJson(json);

  Map<String, dynamic> toJson() => _$JeloModelToJson(this);
}