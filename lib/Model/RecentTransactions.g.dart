// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RecentTransactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentTransaction _$RecentTransactionFromJson(Map<String, dynamic> json) =>
    RecentTransaction(
      madeBy: json['madeBy'] as String?,
      financeDescription: json['financeDescription'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentType: json['paymentType'] as String,
    );

Map<String, dynamic> _$RecentTransactionToJson(RecentTransaction instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('madeBy', toNull(instance.madeBy));
  val['financeDescription'] = instance.financeDescription;
  val['amount'] = instance.amount;
  val['paymentType'] = instance.paymentType;
  return val;
}
