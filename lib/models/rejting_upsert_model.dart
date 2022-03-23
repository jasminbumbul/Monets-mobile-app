import 'package:json_annotation/json_annotation.dart';

part 'rejting_upsert_model.g.dart';

@JsonSerializable()
class RejtingUpsertModel{
  final double? ocjena;
  final int? jeloId, klijentId;


  RejtingUpsertModel(this.ocjena, this.jeloId, this.klijentId);

  factory RejtingUpsertModel.fromJson(Map<String, dynamic> json)=> _$RejtingUpsertModelFromJson(json);

  Map<String, dynamic> toJson() => _$RejtingUpsertModelToJson(this);
}