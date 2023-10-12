import 'dart:convert';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/models/organisation_image_model.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:8000";

  Future<List<Organisation>> getAllOrganisations() async {
    final Uri url = Uri.parse("$baseUrl/organisation/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Organisation>.from(jsonData.map((item) => Organisation.fromJson(item)));
    } else {
      throw Exception('Failed to load organisations');
    }
  }
 Future<Organisation> createOrganisation(Organisation newOrg) async {
  final Uri url = Uri.parse("$baseUrl/organisation/create/");
  final Map<String, dynamic> orgData = newOrg.toJson(); // Assuming you have a toJson method in your Organisation model

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
  final Uri url = Uri.parse("$baseUrl/organisation/withorgadminprojectadminprojectmember/$orgId");

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    print('Received data from API+++++++++++++++++++++++++++++++++++++++++++: $jsonData'); // Add this line to print the received data
    return Organisationremodel.fromJson(jsonData);
  } else {
    throw Exception('Failed to load organisation data');
  }
}


  }

