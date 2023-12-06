import 'package:json_annotation/json_annotation.dart';

import 'Locals.dart';

part 'Organisations.g.dart';

@JsonSerializable()
class Organisations {
  int id;
  String organisation;
  Locals locals;

  Organisations({
    required this.id,
    required this.organisation,
    required this.locals,
  });

  factory Organisations.fromJson(Map<String, dynamic> json) =>
      _$OrganisationsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganisationsToJson(this);
}
toNull(_) => null;