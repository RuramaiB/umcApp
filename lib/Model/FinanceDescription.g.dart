// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FinanceDescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceDescription _$FinanceDescriptionFromJson(Map<String, dynamic> json) =>
    FinanceDescription(
      description: json['description'] as String,
      grandTarget: (json['grandTarget'] as num).toDouble(),
      kickOff: json['kickOff'],
      locals: Locals.fromJson(json['locals'] as Map<String, dynamic>),
      id: json['id'] as int,
    );

Map<String, dynamic> _$FinanceDescriptionToJson(FinanceDescription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', toNull(instance.description));
  val['grandTarget'] = instance.grandTarget;
  val['kickOff'] = instance.kickOff;
  val['locals'] = instance.locals;
  val['id'] = instance.id;
  return val;
}
