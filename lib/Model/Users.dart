import 'package:json_annotation/json_annotation.dart';

import 'Locals.dart';
import 'Section.dart';

part 'Users.g.dart';


@JsonSerializable()
class Users {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final int? id;
  final String firstname;
  final String lastname;
  final String gender;
  final List<int>? dateOfBirth;
  final String? phoneNumber;
  final String membershipNumber;
  final String? password;
  final String? role;
  final String? organisation;
  final String? membershipStatus;
  final Locals? locals;
  final Section? section;

  Users({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.gender,
     this.dateOfBirth,
     this.phoneNumber,
    required this.membershipNumber,
     this.password,
     this.role,
     this.organisation,
     this.membershipStatus,
     this.locals,
     this.section,
  });

  factory Users.fromJson(Map<String, dynamic> json) =>
      _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
toNull(_) => null;