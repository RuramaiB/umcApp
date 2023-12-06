import 'package:json_annotation/json_annotation.dart';

import 'FinanceDescription.dart';
import 'Locals.dart';

part 'FinancialTargets.g.dart';

@JsonSerializable()
class FinancialTargets {
  final int id;
  final double amount;
  final String level;
  final String target;
  final bool edited;
  final FinanceDescription financeDescription;
  final Locals locals;

  FinancialTargets({
    required this.id,
    required this.amount,
    required this.level,
    required this.target,
    required this.edited,
    required this.financeDescription,
    required this.locals,
  });

  factory FinancialTargets.fromJson(Map<String, dynamic> json) =>
      _$FinancialTargetsFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialTargetsToJson(this);
}