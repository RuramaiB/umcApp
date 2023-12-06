
import 'package:json_annotation/json_annotation.dart';

import 'Locals.dart';

part 'FinanceDescription.g.dart';
@JsonSerializable()
class FinanceDescription {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String description;
  final double grandTarget;
  final dynamic kickOff;
  final Locals locals;
  final int id;

  FinanceDescription({
    required this.description,
    required this.grandTarget,
    required this.kickOff,
    required this.locals,
    required this.id,
  });

  factory FinanceDescription.fromJson(Map<String, dynamic> json) =>
      _$FinanceDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceDescriptionToJson(this);
}
toNull(_) => null;