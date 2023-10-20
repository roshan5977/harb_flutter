import 'dart:convert';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/models/organisation_image_model.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:harbinger_flutter/models/user_model.dart';
import 'package:harbinger_flutter/models/workspace_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:8000";

  Future<List<Organisation>> getAllOrganisations() async {
    final Uri url = Uri.parse("$baseUrl/organisation/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Organisation>.from(
          jsonData.map((item) => Organisation.fromJson(item)));
    } else {
      throw Exception('Failed to load organisations');
    }
  }

  Future<Organisation> createOrganisation(Organisation newOrg) async {
    final Uri url = Uri.parse("$baseUrl/organisation/create/");
    final Map<String, dynamic> orgData = newOrg
        .toJson(); // Assuming you have a toJson method in your Organisation model

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(orgData),
    );

    // Print the response for debugging purposes
    print("API Response: ${response.statusCode} - ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return Organisation.fromJson(jsonData);
    } else {
      throw Exception('Failed to create a new organization');
    }
  }

  // Future<String> changeStatusOfOrganisation(int orgId) async {
  //   final Uri url = Uri.parse("$baseUrl/organisation/status/$orgId/");
  //   final response = await http.patch(url);

  //   if (response.statusCode == 200) {
  //     return "Status changed successfully";
  //   } else {
  //     throw Exception('Failed to change status of organisation');
  //   }
  // }

  Future<OrganisationImage> getOrgImage(int orgRefId) async {
    final Uri url = Uri.parse("$baseUrl/organisation/upload_org_img/$orgRefId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List && jsonData.isNotEmpty) {
        return OrganisationImage.fromJson(jsonData[0]);
      } else {
        throw Exception('No organization image data found');
      }
    } else {
      throw Exception('Failed to load organization image');
    }
  }

  Future<Organisationremodel> getOrganisationWithRelations(int orgId) async {
    final Uri url = Uri.parse(
        "$baseUrl/organisation/withorgadminprojectadminprojectmember/$orgId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(
          'Received data from API+++++++++++++++++++++++++++++++++++++++++++: $jsonData'); // Add this line to print the received data
      return Organisationremodel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load organisation data');
    }
  }

  Future<User> registerUser(int orgId, User user, int roleRefId) async {
    user.roleRefId = roleRefId;
    final response = await http.post(
      Uri.parse('$baseUrl/user/register/$orgId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final registeredUser = User.fromJson(jsonDecode(response.body));
      print(
          'User registration successful: ${registeredUser.firstName} ${registeredUser.lastName}');
      return registeredUser;
    } else {
      final errorMessage = 'Failed to register user: ${response.statusCode}';
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<bool> checkenv() async {
    final response = await http.get(Uri.parse('$baseUrl/env/check/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['git_info,node info,python info'] == true;
    } else {
      throw Exception('Failed to check all installation');
    }
  }

  Future<List<Workspace>> getWorkspaces(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/workspace/$userId'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final List<dynamic> jsonData = json.decode(response.body);
      List<Workspace> workspaces =
          jsonData.map((json) => Workspace.fromJson(json)).toList();
      return workspaces;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load workspaces');
    }
  }

  Future<Workspace> createWorkspace(Workspace workspace) async {
    final response = await http.post(
      Uri.parse('$baseUrl/workspace/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(workspace.toJson()),
    );
    final Map<String, dynamic> newworkspace = workspace.toJson();
    print("response$response");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("responseData$responseData");

      // return Workspace(
      //   workspaceName: responseData['workspace_name'],
      //   workspacePath: responseData['workspace_path'],
      //   devMacAddress: responseData['dev_mac_address'],
      //   isOrphan: responseData['is_orphan'],
      //   userRefId:  responseData['user_ref_id'],
      //   workspaceId:  responseData['workspace_id'],
      //   // Add other fields as needed
      // );
      return Workspace.fromJson(responseData);
    } else {
      throw Exception('Failed to create workspace: ${response.statusCode}');
    }
  }

  
}
