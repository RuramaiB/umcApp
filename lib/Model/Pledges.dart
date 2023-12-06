import 'package:json_annotation/json_annotation.dart';
import 'package:umc_finance/Model/Users.dart';
import 'Locals.dart';

part 'Pledges.g.dart';

@JsonSerializable()
class Pledges {
  final int? financeID;
  final double? amount;
  final String paymentMethod;
  final String membershipNumber;
  final List<int>? dateOfPayment;
  final String phoneNumber;
  final String currency;
  final String locals;
  final String financeDescription;

  Pledges({
     this.financeID,
    required this.amount,
    required this.paymentMethod,
    required this.membershipNumber,
     this.dateOfPayment,
    required this.phoneNumber,
    required this.currency,
    required this.locals,
    required this.financeDescription,
  });

  factory Pledges.fromJson(Map<String, dynamic> json) =>
      _$PledgesFromJson(json);

  Map<String, dynamic> toJson() => _$PledgesToJson(this);
}