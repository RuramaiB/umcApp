import 'package:json_annotation/json_annotation.dart';

import 'FinanceDescription.dart';
import 'Locals.dart';
import 'Users.dart';

part 'LocalFinances.g.dart';

@JsonSerializable()
class LocalFinances {
  @JsonKey(toJson: toNull, includeIfNull: false)
  final int? financeID;
  final double? amount;
  final String paymentMethod;
  final String membershipNumber;
  final List<int>? dateOfPayment;
  final String phoneNumber;
  final String financeDescription;
  final Users? user;
  final String currency;
  final String locals;

  LocalFinances({
     this.financeID,
    required this.amount,
    required this.paymentMethod,
    required this.membershipNumber,
    this.dateOfPayment,
    required this.phoneNumber,
    required this.financeDescription,
     this.user,
    required this.currency,
     required this.locals,
  });
  factory LocalFinances.fromJson(Map<String, dynamic> json) =>
      _$LocalFinancesFromJson(json);

  Map<String, dynamic> toJson() => _$LocalFinancesToJson(this);
}
toNull(_) => null;



