import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';
@JsonSerializable()
class UserModel {
  final String membershipNumber;
  final String password;
  final String? local;

  UserModel({this.local, required this.membershipNumber, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
toNull(_) => null;
