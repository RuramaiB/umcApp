// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FinancialTargets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialTargets _$FinancialTargetsFromJson(Map<String, dynamic> json) =>
    FinancialTargets(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      level: json['level'] as String,
      target: json['target'] as String,
      edited: json['edited'] as bool,
      financeDescription: FinanceDescription.fromJson(
          json['financeDescription'] as Map<String, dynamic>),
      locals: Locals.fromJson(json['locals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinancialTargetsToJson(FinancialTargets instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'level': instance.level,
      'target': instance.target,
      'edited': instance.edited,
      'financeDescription': instance.financeDescription,
      'locals': instance.locals,
    };
