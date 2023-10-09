import 'dart:convert';

class ProjectMember {
  int projectMemberId;
  String emailId;
  int orgRefId;
  int projectAdminRefId;

  ProjectMember({
    this.projectMemberId = 0,
    required this.emailId,
    required this.orgRefId,
    required this.projectAdminRefId,
  });

  factory ProjectMember.fromJson(Map<String, dynamic> map) {
    return ProjectMember(
      projectMemberId: map['project_member_id'],
      emailId: map['email_id'],
      orgRefId: map['org_ref_id'],
      projectAdminRefId: map['project_admin_ref_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_member_id': projectMemberId,
      'email_id': emailId,
      'org_ref_id': orgRefId,
      'project_admin_ref_id': projectAdminRefId,
    };
  }

  @override
  String toString() {
    return 'ProjectMember{projectMemberId: $projectMemberId, emailId: $emailId, orgRefId: $orgRefId, projectAdminRefId: $projectAdminRefId}';
  }
}

List<ProjectMember> projectMembersFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ProjectMember>.from(data.map((item) => ProjectMember.fromJson(item)));
}

String projectMembersToJson(List<ProjectMember> data) {
  final jsonData = data.map((member) => member.toJson()).toList();
  return json.encode(jsonData);
}
