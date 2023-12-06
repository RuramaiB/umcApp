// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocalFinances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalFinances _$LocalFinancesFromJson(Map<String, dynamic> json) =>
    LocalFinances(
      financeID: json['financeID'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      membershipNumber: json['membershipNumber'] as String,
      dateOfPayment: (json['dateOfPayment'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      phoneNumber: json['phoneNumber'] as String,
      financeDescription: json['financeDescription'] as String,
      user: json['user'] == null
          ? null
          : Users.fromJson(json['user'] as Map<String, dynamic>),
      currency: json['currency'] as String,
      locals: json['locals'] as String,
    );

Map<String, dynamic> _$LocalFinancesToJson(LocalFinances instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('financeID', toNull(instance.financeID));
  val['amount'] = instance.amount;
  val['paymentMethod'] = instance.paymentMethod;
  val['membershipNumber'] = instance.membershipNumber;
  val['dateOfPayment'] = instance.dateOfPayment;
  val['phoneNumber'] = instance.phoneNumber;
  val['financeDescription'] = instance.financeDescription;
  val['user'] = instance.user;
  val['currency'] = instance.currency;
  val['locals'] = instance.locals;
  return val;
}
