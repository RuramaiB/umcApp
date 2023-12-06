import 'package:json_annotation/json_annotation.dart';

import 'Locals.dart';

part 'PaymentMethods.g.dart';

@JsonSerializable()
class PaymentMethods {
  final int id;
  final String paymentMethod;
  final String currency;
  final Locals locals;

  PaymentMethods({
    required this.id,
    required this.paymentMethod,
    required this.currency,
    required this.locals,
  });

  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}
toNull(_) => null;