import 'dart:convert';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = AppConstants.BASE_URL;

  Future<List<Organisation>> getAllOrganisations() async {
    
    final Uri url = Uri.parse("$baseUrl/organisation/"); 
    final response = await http.get(url);

      if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    print("API Response ++++++++++++++++++++++++++++++++++++++++++++++++++++: $jsonData");
    return List<Organisation>.from(jsonData.map((item) => Organisation.fromJson(item)));
  } else {
    print("Failed to load organisations++++++++++++++++++++++++++++++++: ${response.statusCode}");
    throw Exception('Failed to load organisations');
  }
  }

  Future<void> createOrganisation(Organisation organisation) async {
    final Uri url = Uri.parse("$baseUrl/organisation/create/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: organisationToJson(organisation),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create organisation');
    }
  }

  Future<void> updateOrganisation(Organisation organisation) async {
    final Uri url = Uri.parse("$baseUrl/organisation/update/${organisation.orgId}");
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: organisationToJson(organisation),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update organisation');
    }
  }

  // Future<void> patchOrganisation(int orgId, Map<String, dynamic> newData) async {
  //   final Uri url = Uri.parse("$baseUrl/api/organisation/$orgId"); 
  //   final response = await http.patch(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(newData),
  //   );
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to patch organisation');
  //   }
  // }

  // Future<void> deleteOrganisation(int orgId) async {
  //   final Uri url = Uri.parse("$baseUrl/api/organisation/$orgId"); 
  //   final response = await http.delete(url);
  //   if (response.statusCode != 204) {
  //     throw Exception('Failed to delete organisation');
  //   }
  // }
}
