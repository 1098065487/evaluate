import 'package:json_annotation/json_annotation.dart'; 
  
part 'config_type.g.dart';


@JsonSerializable()
  class ConfigType extends Object {

  @JsonKey(name: 'padId')
  int padId;

  @JsonKey(name: 'departments')
  List<Departments> departments;

  ConfigType(this.padId,this.departments,);

  factory ConfigType.fromJson(Map<String, dynamic> srcJson) => _$ConfigTypeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ConfigTypeToJson(this);

}

  
@JsonSerializable()
  class Departments extends Object {

  @JsonKey(name: 'departmentName')
  String departmentName;

  @JsonKey(name: 'dpartmentId')
  int dpartmentId;

  @JsonKey(name: 'subject')
  List<Subject> subject;

  Departments(this.departmentName,this.dpartmentId,this.subject,);

  factory Departments.fromJson(Map<String, dynamic> srcJson) => _$DepartmentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepartmentsToJson(this);

}

  
@JsonSerializable()
  class Subject extends Object {

  @JsonKey(name: 'ticketTypeArr')
  List<TicketTypeArr> ticketTypeArr;

  @JsonKey(name: 'subjectId')
  int subjectId;

  @JsonKey(name: 'subjectName')
  String subjectName;

  Subject(this.ticketTypeArr,this.subjectId,this.subjectName,);

  factory Subject.fromJson(Map<String, dynamic> srcJson) => _$SubjectFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);

}

  
@JsonSerializable()
  class TicketTypeArr extends Object {

  @JsonKey(name: 'pdss')
  List<Pdss> pdss;

  @JsonKey(name: 'ticketType')
  String ticketType;

  TicketTypeArr(this.pdss,this.ticketType,);

  factory TicketTypeArr.fromJson(Map<String, dynamic> srcJson) => _$TicketTypeArrFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TicketTypeArrToJson(this);

}

  
@JsonSerializable()
  class Pdss extends Object {

  @JsonKey(name: 'pdssId')
  int pdssId;

  @JsonKey(name: 'ticketId')
  List<int> ticketId;

  @JsonKey(name: 'ticketName')
  String ticketName;

  Pdss(this.pdssId,this.ticketId,this.ticketName,);

  factory Pdss.fromJson(Map<String, dynamic> srcJson) => _$PdssFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PdssToJson(this);

}

  
