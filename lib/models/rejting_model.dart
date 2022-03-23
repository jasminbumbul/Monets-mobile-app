import 'package:json_annotation/json_annotation.dart';

part 'rejting_model.g.dart';

@JsonSerializable()
class RejtingModel{
  final double? ocjena;
  final int? jeloId, klijentId, rejtingId;

  RejtingModel(this.ocjena, this.jeloId, this.klijentId, this.rejtingId);

  factory RejtingModel.fromJson(Map<String, dynamic> json)=> _$RejtingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RejtingModelToJson(this);
}