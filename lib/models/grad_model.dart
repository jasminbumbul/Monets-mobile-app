import 'package:json_annotation/json_annotation.dart';

part 'grad_model.g.dart';

@JsonSerializable()
class GradModel{
  final int? gradId;
  final String? naziv;

  GradModel(this.gradId, this.naziv);

  factory GradModel.fromJson(Map<String, dynamic> json)=> _$GradModelFromJson(json);

  Map<String, dynamic> toJson() => _$GradModelToJson(this);
}