import 'package:json_annotation/json_annotation.dart';
import 'package:umc_finance/Model/FinanceDescription.dart';
import 'package:umc_finance/Model/Locals.dart';

import 'Organisations.dart';
import 'Users.dart';

part 'OrganisationFinances.g.dart';

@JsonSerializable()
class OrganisationFinance {
  final int? financeID;
  final double? amount;
  final List<int>? dateOfPayment;
  final String paymentMethod;
  final String membershipNumber;
  final String currency;
  final String phoneNumber;
  final String financeDescription;
  final String locals;

  OrganisationFinance({
    this.financeID,
    required this.locals,
    required this.amount,
    this.dateOfPayment,
    required this.paymentMethod,
    required this.membershipNumber,
    required this.currency,
    required this.phoneNumber,
    required this.financeDescription
  });

  factory OrganisationFinance.fromJson(Map<String, dynamic> json) =>
      _$OrganisationFinanceFromJson(json);

  Map<String, dynamic> toJson() => _$OrganisationFinanceToJson(this);
}
toNull(_) => null;

