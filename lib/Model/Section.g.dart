// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      id: json['id'] as int,
      name: json['name'] as String,
      locals: Locals.fromJson(json['locals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionToJson(Section instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', toNull(instance.id));
  val['name'] = instance.name;
  val['locals'] = instance.locals;
  return val;
}
