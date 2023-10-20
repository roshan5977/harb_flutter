import 'dart:convert';
import 'package:harbinger_flutter/models/project_model.dart';
import 'package:http/http.dart' as http;
 
class ProjectService {
  final String baseUrl = "http://localhost:8000";
 
  Future<Project> createProject(Project newProject) async {
    final Uri url = Uri.parse("$baseUrl/project/create/");
    final Map<String, dynamic> projectData = newProject.toJson();
 
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(projectData),
    );
 
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Project.fromJson(jsonData);
    } else {
      throw Exception('Failed to load projects');
    }
  }
 
 Future<void> saveProjectDetails({
  required String projectName,
  required String gitUrl,
  required String workspacePath,
  String? cdRequired,
  String? cdOptionSelected,
  String? ciUrl,
  String? ciApiKey,
}) async {
  final client = http.Client();
 
  try {
    final Map<String, dynamic> requestData = {
      'projectName': projectName,
      'gitUrl': gitUrl,
      'workspacePath': workspacePath,
    };
 
    if (cdRequired != null) {
      requestData['cdRequired'] = cdRequired;
    }
 
    if (cdOptionSelected != null) {
      requestData['cdOptionSelected'] = cdOptionSelected;
    }
 
    if (ciUrl != null) {
      requestData['ciUrl'] = ciUrl;
    }
 
    if (ciApiKey != null) {
      requestData['ciApiKey'] = ciApiKey;
    }
 
    final response = await client.post(
      Uri.parse('$baseUrl/project/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );
 
    if (response.statusCode != 200) {
      throw Exception('Failed to save project details');
    }
  } finally {
    client.close();
  }
}
 
}
 
 

