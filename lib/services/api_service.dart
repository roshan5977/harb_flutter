import 'dart:convert';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/models/organisation_image_model.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:harbinger_flutter/models/user_model.dart';
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

  // Future<String[]> sendjsonfile() async {
  //   final response =
  //       await http.get(Uri.parse('http://127.0.0.1:8001//uploadapiinfo/'));
  //   if (response.statusCode == 200) {
  //     return response;

  //   } else {
  //     throw Exception('Failed get all endpoint');
  //   }
  // }
}
