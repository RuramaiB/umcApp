import 'package:json_annotation/json_annotation.dart';

import 'Locals.dart';

part 'Section.g.dart';

@JsonSerializable()
class Section {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final int id;
  final String name;
  final Locals locals;

  Section({
    required this.id,
    required this.name,
    required this.locals,
  });

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
toNull(_) => null;