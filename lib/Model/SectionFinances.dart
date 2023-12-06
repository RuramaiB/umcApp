import 'package:json_annotation/json_annotation.dart';

part 'SectionFinances.g.dart';

@JsonSerializable()
class SectionFinances {
  @JsonKey(toJson: toNull, includeIfNull: false)
  int? financeID;
  String financeDescription;
  double? amount;
  List<int>? dateOfPayment;
  String currency;
  String paymentMethod;
  String membershipNumber;
  String phoneNumber;
  String locals;

  SectionFinances({
     this.financeID,
    required this.financeDescription,
    required this.amount,
     this.dateOfPayment,
    required this.currency,
    required this.paymentMethod,
    required this.membershipNumber,
    required this.phoneNumber,
    required this.locals
  });

  factory SectionFinances.fromJson(Map<String, dynamic> json) =>
      _$SectionFinancesFromJson(json);

  Map<String, dynamic> toJson() => _$SectionFinancesToJson(this);
}
toNull(_) => null;
