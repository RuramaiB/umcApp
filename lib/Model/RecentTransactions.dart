import 'package:json_annotation/json_annotation.dart';

part 'RecentTransactions.g.dart';

@JsonSerializable()
class RecentTransaction {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final String? madeBy;
  final String financeDescription;
  final double amount;
  final String paymentType;

  RecentTransaction({
    this.madeBy,
    required this.financeDescription,
    required this.amount,
    required this.paymentType,
  });
  factory RecentTransaction.fromJson(Map<String, dynamic> json) =>
      _$RecentTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTransactionToJson(this);
}
toNull(_) => null;