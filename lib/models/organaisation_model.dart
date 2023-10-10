import 'dart:convert';

class Organisation {
  int orgId;
  String orgName; 
  String orgCode;
  String orgDesc;
  DateTime orgStartDate;
  DateTime orgEndDate;
  String status;
  String createdBy;
  String updatedBy;
  DateTime createdOn;
  DateTime updatedOn;

  Organisation({
    this.orgId = 0,
    required this.orgName, 
    this.orgCode = '',
    this.orgDesc = '',
    required this.orgStartDate,
    required this.orgEndDate,
    this.status = '',
    this.createdBy = '',
    this.updatedBy = '',
    required this.createdOn,
    required this.updatedOn,
  });

  factory Organisation.fromJson(Map<String, dynamic> map) {
    return Organisation(
      orgId: map['org_id'],
      orgName: map['org_name'],
      orgCode: map['org_code'],
      orgDesc: map['org_desc'],
      orgStartDate: DateTime.parse(map['org_start_date']),
      orgEndDate: DateTime.parse(map['org_end_date']),
      status: map['status'],
      createdBy: map['created_by'],
      updatedBy: map['updated_by'],
      createdOn: DateTime.parse(map['created_on']),
      updatedOn: DateTime.parse(map['updated_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'org_id': orgId,
      'org_name': orgName,
      'org_code': orgCode,
      'org_desc': orgDesc,
      'org_start_date': orgStartDate.toIso8601String(),
      'org_end_date': orgEndDate.toIso8601String(),
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_on': createdOn.toIso8601String(),
      'updated_on': updatedOn.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Organisation{orgId: $orgId, orgName: $orgName, orgCode: $orgCode, orgDesc: $orgDesc, orgStartDate: $orgStartDate, orgEndDate: $orgEndDate, status: $status, createdBy: $createdBy, updatedBy: $updatedBy, createdOn: $createdOn, updatedOn: $updatedOn}';
  }
}

List<Organisation> organisationFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Organisation>.from(data.map((item) => Organisation.fromJson(item)));
}

String organisationToJson(Organisation data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
