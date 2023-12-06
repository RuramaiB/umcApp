// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pledges.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pledges _$PledgesFromJson(Map<String, dynamic> json) => Pledges(
      financeID: json['financeID'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      membershipNumber: json['membershipNumber'] as String,
      dateOfPayment: (json['dateOfPayment'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      phoneNumber: json['phoneNumber'] as String,
      currency: json['currency'] as String,
      locals: json['locals'] as String,
      financeDescription: json['financeDescription'] as String,
    );

Map<String, dynamic> _$PledgesToJson(Pledges instance) => <String, dynamic>{
      'financeID': instance.financeID,
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'membershipNumber': instance.membershipNumber,
      'dateOfPayment': instance.dateOfPayment,
      'phoneNumber': instance.phoneNumber,
      'currency': instance.currency,
      'locals': instance.locals,
      'financeDescription': instance.financeDescription,
    };
