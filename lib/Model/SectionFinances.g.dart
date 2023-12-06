// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SectionFinances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionFinances _$SectionFinancesFromJson(Map<String, dynamic> json) =>
    SectionFinances(
      financeID: json['financeID'] as int?,
      financeDescription: json['financeDescription'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      dateOfPayment: (json['dateOfPayment'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      currency: json['currency'] as String,
      paymentMethod: json['paymentMethod'] as String,
      membershipNumber: json['membershipNumber'] as String,
      phoneNumber: json['phoneNumber'] as String,
      locals: json['locals'] as String,
    );

Map<String, dynamic> _$SectionFinancesToJson(SectionFinances instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('financeID', toNull(instance.financeID));
  val['financeDescription'] = instance.financeDescription;
  val['amount'] = instance.amount;
  val['dateOfPayment'] = instance.dateOfPayment;
  val['currency'] = instance.currency;
  val['paymentMethod'] = instance.paymentMethod;
  val['membershipNumber'] = instance.membershipNumber;
  val['phoneNumber'] = instance.phoneNumber;
  val['locals'] = instance.locals;
  return val;
}
