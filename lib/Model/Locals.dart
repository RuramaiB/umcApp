import 'package:json_annotation/json_annotation.dart';

part 'Locals.g.dart';

@JsonSerializable()
class Locals {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final int id;
  final String name;
  final String location;
  final String prefix;

  Locals({
    required this.id,
    required this.name,
    required this.location,
    required this.prefix,
  });

  factory Locals.fromJson(Map<String, dynamic> json) =>
      _$LocalsFromJson(json);

  Map<String, dynamic> toJson() => _$LocalsToJson(this);
}
toNull(_) => null;