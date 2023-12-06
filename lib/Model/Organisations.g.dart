// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Organisations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisations _$OrganisationsFromJson(Map<String, dynamic> json) =>
    Organisations(
      id: json['id'] as int,
      organisation: json['organisation'] as String,
      locals: Locals.fromJson(json['locals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganisationsToJson(Organisations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organisation': instance.organisation,
      'locals': instance.locals,
    };
