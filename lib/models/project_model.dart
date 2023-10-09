import 'dart:convert';

class Project {
  int projectId;
  String projectName;
  bool isOrphan;
  String gitUrl;
  String ciUsed;
  String ciUrl;
  String ciApiKey;
  int workspaceRefId;
  int orgRefId;

  Project({
    this.projectId = 0,
    required this.projectName,
    this.isOrphan = false,
    this.gitUrl = '',
    this.ciUsed = '',
    this.ciUrl = '',
    this.ciApiKey = '',
    this.workspaceRefId = 0,
    this.orgRefId = 0,
  });

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      projectId: map['project_id'],
      projectName: map['project_name'],
      isOrphan: map['is_orphan'],
      gitUrl: map['git_url'],
      ciUsed: map['ci_used'],
      ciUrl: map['ci_url'],
      ciApiKey: map['ci_api_key'],
      workspaceRefId: map['workspace_ref_id'],
      orgRefId: map['org_ref_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'project_name': projectName,
      'is_orphan': isOrphan,
      'git_url': gitUrl,
      'ci_used': ciUsed,
      'ci_url': ciUrl,
      'ci_api_key': ciApiKey,
      'workspace_ref_id': workspaceRefId,
      'org_ref_id': orgRefId,
    };
  }

  @override
  String toString() {
    return 'Project{projectId: $projectId, projectName: $projectName, isOrphan: $isOrphan, gitUrl: $gitUrl, ciUsed: $ciUsed, ciUrl: $ciUrl, ciApiKey: $ciApiKey, workspaceRefId: $workspaceRefId, orgRefId: $orgRefId}';
  }
}

List<Project> projectFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Project>.from(data.map((item) => Project.fromJson(item)));
}

String projectToJson(Project data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
