import 'package:json_annotation/json_annotation.dart';

part 'vrijeme_model.g.dart';

@JsonSerializable()
class VrijemeModel{
  final DateTime? vrijeme;
  final bool? isSlobodno;

  VrijemeModel(this.vrijeme, this.isSlobodno);

  factory VrijemeModel.fromJson(Map<String, dynamic> json)=> _$VrijemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$VrijemeModelToJson(this);
}