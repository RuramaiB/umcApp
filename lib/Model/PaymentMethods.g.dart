// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentMethods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      id: json['id'] as int,
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String,
      locals: Locals.fromJson(json['locals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentMethod': instance.paymentMethod,
      'currency': instance.currency,
      'locals': instance.locals,
    };
