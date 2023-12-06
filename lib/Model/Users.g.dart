// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      id: json['id'] as int?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      gender: json['gender'] as String,
      dateOfBirth: (json['dateOfBirth'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      membershipNumber: json['membershipNumber'] as String,
      password: json['password'] as String?,
      role: json['role'] as String?,
      organisation: json['organisation'] as String?,
      membershipStatus: json['membershipStatus'] as String?,
      locals: json['locals'] == null
          ? null
          : Locals.fromJson(json['locals'] as Map<String, dynamic>),
      section: json['section'] == null
          ? null
          : Section.fromJson(json['section'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersToJson(Users instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', toNull(instance.id));
  val['firstname'] = instance.firstname;
  val['lastname'] = instance.lastname;
  val['gender'] = instance.gender;
  val['dateOfBirth'] = instance.dateOfBirth;
  val['phoneNumber'] = instance.phoneNumber;
  val['membershipNumber'] = instance.membershipNumber;
  val['password'] = instance.password;
  val['role'] = instance.role;
  val['organisation'] = instance.organisation;
  val['membershipStatus'] = instance.membershipStatus;
  val['locals'] = instance.locals;
  val['section'] = instance.section;
  return val;
}
