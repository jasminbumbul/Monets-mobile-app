import 'package:json_annotation/json_annotation.dart';

part 'favorit_model.g.dart';

@JsonSerializable()
class FavoritModel{
  final int? favoritId, jeloId, klijentId;

  FavoritModel(this.favoritId, this.jeloId, this.klijentId);

  factory FavoritModel.fromJson(Map<String, dynamic> json)=> _$FavoritModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritModelToJson(this);
}