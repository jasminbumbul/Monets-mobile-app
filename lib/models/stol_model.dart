import 'package:json_annotation/json_annotation.dart';

part 'stol_model.g.dart';

@JsonSerializable()
class StolModel{
  final int? stolId, brojMjesta;
  final String? nazivStola;

  StolModel(this.stolId, this.brojMjesta, this.nazivStola);

  factory StolModel.fromJson(Map<String, dynamic> json) => _$StolModelFromJson(json);

  Map<String, dynamic> toJson() => _$StolModelToJson(this);
}