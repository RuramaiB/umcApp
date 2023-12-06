// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Locals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locals _$LocalsFromJson(Map<String, dynamic> json) => Locals(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      prefix: json['prefix'] as String,
    );

Map<String, dynamic> _$LocalsToJson(Locals instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', toNull(instance.id));
  val['name'] = instance.name;
  val['location'] = instance.location;
  val['prefix'] = instance.prefix;
  return val;
}
