// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigType _$ConfigTypeFromJson(Map<String, dynamic> json) => ConfigType(
      json['padId'] as int,
      (json['departments'] as List<dynamic>)
          .map((e) => Departments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfigTypeToJson(ConfigType instance) =>
    <String, dynamic>{
      'padId': instance.padId,
      'departments': instance.departments,
    };

Departments _$DepartmentsFromJson(Map<String, dynamic> json) => Departments(
      json['departmentName'] as String,
      json['dpartmentId'] as int,
      (json['subject'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentsToJson(Departments instance) =>
    <String, dynamic>{
      'departmentName': instance.departmentName,
      'dpartmentId': instance.dpartmentId,
      'subject': instance.subject,
    };

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      (json['ticketTypeArr'] as List<dynamic>)
          .map((e) => TicketTypeArr.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['subjectId'] as int,
      json['subjectName'] as String,
    );

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'ticketTypeArr': instance.ticketTypeArr,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
    };

TicketTypeArr _$TicketTypeArrFromJson(Map<String, dynamic> json) =>
    TicketTypeArr(
      (json['pdss'] as List<dynamic>)
          .map((e) => Pdss.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['ticketType'] as String,
    );

Map<String, dynamic> _$TicketTypeArrToJson(TicketTypeArr instance) =>
    <String, dynamic>{
      'pdss': instance.pdss,
      'ticketType': instance.ticketType,
    };

Pdss _$PdssFromJson(Map<String, dynamic> json) => Pdss(
      json['pdssId'] as int,
      (json['ticketId'] as List<dynamic>).map((e) => e as int).toList(),
      json['ticketName'] as String,
    );

Map<String, dynamic> _$PdssToJson(Pdss instance) => <String, dynamic>{
      'pdssId': instance.pdssId,
      'ticketId': instance.ticketId,
      'ticketName': instance.ticketName,
    };
