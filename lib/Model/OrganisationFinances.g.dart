// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrganisationFinances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganisationFinance _$OrganisationFinanceFromJson(Map<String, dynamic> json) =>
    OrganisationFinance(
      financeID: json['financeID'] as int?,
      locals: json['locals'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      dateOfPayment: (json['dateOfPayment'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      paymentMethod: json['paymentMethod'] as String,
      membershipNumber: json['membershipNumber'] as String,
      currency: json['currency'] as String,
      phoneNumber: json['phoneNumber'] as String,
      financeDescription: json['financeDescription'] as String,
    );

Map<String, dynamic> _$OrganisationFinanceToJson(
        OrganisationFinance instance) =>
    <String, dynamic>{
      'financeID': instance.financeID,
      'amount': instance.amount,
      'dateOfPayment': instance.dateOfPayment,
      'paymentMethod': instance.paymentMethod,
      'membershipNumber': instance.membershipNumber,
      'currency': instance.currency,
      'phoneNumber': instance.phoneNumber,
      'financeDescription': instance.financeDescription,
      'locals': instance.locals,
    };
