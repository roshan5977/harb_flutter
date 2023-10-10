
import 'dart:convert';

class Workspace {
  int workspaceId;
  String workspaceName;
  String workspacePath;
  String devMacAddress;
  String devOs;
  bool isOrphan;
  int userRefId;

  Workspace({
    this.workspaceId = 0,
    required this.workspaceName,
    required this.workspacePath,
    required this.devMacAddress,
    required this.devOs,
    this.isOrphan = false,
    this.userRefId = 0,
  });

  factory Workspace.fromJson(Map<String, dynamic> map) {
    return Workspace(
      workspaceId: map['workspace_id'],
      workspaceName: map['workspace_name'],
      workspacePath: map['workspace_path'],
      devMacAddress: map['dev_mac_address'],
      devOs: map['dev_os'],
      isOrphan: map['is_orphan'],
      userRefId: map['user_ref_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workspace_id': workspaceId,
      'workspace_name': workspaceName,
      'workspace_path': workspacePath,
      'dev_mac_address': devMacAddress,
      'dev_os': devOs,
      'is_orphan': isOrphan,
      'user_ref_id': userRefId,
    };
  }

  @override
  String toString() {
    return 'Workspace{workspaceId: $workspaceId, workspaceName: $workspaceName, workspacePath: $workspacePath, devMacAddress: $devMacAddress, devOs: $devOs, isOrphan: $isOrphan, userRefId: $userRefId}';
  }
}

List<Workspace> workspaceFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Workspace>.from(data.map((item) => Workspace.fromJson(item)));
}

String workspaceToJson(Workspace data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
