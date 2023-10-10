import 'dart:convert';

class ProjectAdmin {
  int projectAdminId;
  String emailId;
  int orgRefId;

  ProjectAdmin({
    this.projectAdminId = 0,
    required this.emailId,
    required this.orgRefId,
  });

  factory ProjectAdmin.fromJson(Map<String, dynamic> map) {
    return ProjectAdmin(
      projectAdminId: map['project_admin_id'],
      emailId: map['email_id'],
      orgRefId: map['org_ref_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_admin_id': projectAdminId,
      'email_id': emailId,
      'org_ref_id': orgRefId,
    };
  }

  @override
  String toString() {
    return 'ProjectAdmin{projectAdminId: $projectAdminId, emailId: $emailId, orgRefId: $orgRefId}';
  }
}

List<ProjectAdmin> projectAdminsFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ProjectAdmin>.from(data.map((item) => ProjectAdmin.fromJson(item)));
}

String projectAdminsToJson(List<ProjectAdmin> data) {
  final jsonData = data.map((admin) => admin.toJson()).toList();
  return json.encode(jsonData);
}
