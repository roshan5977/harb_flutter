import 'dart:convert';

class OrganisationAdmin {
  int orgAdminId;
  String emailId;
  int orgRefId;

  OrganisationAdmin({
    this.orgAdminId = 0,
    required this.emailId,
    required this.orgRefId,
  });

  factory OrganisationAdmin.fromJson(Map<String, dynamic> map) {
    return OrganisationAdmin(
      orgAdminId: map['org_admin_id'],
      emailId: map['email_id'],
      orgRefId: map['org_ref_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'org_admin_id': orgAdminId,
      'email_id': emailId,
      'org_ref_id': orgRefId,
    };
  }

  @override
  String toString() {
    return 'OrganisationAdmin{orgAdminId: $orgAdminId, emailId: $emailId, orgRefId: $orgRefId}';
  }
}

List<OrganisationAdmin> organisationAdminsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<OrganisationAdmin>.from(data.map((item) => OrganisationAdmin.fromJson(item)));
}

String organisationAdminsToJson(List<OrganisationAdmin> data) {
  final jsonData = data.map((admin) => admin.toJson()).toList();
  return json.encode(jsonData);
}
