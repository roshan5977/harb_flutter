import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/screens/moreinfo_screen_model.dart';

import 'package:harbinger_flutter/services/organisation_service.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organisation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrganisationScreen(),
    );
  }
}

class OrganisationScreen extends StatefulWidget {
  @override
  _OrganisationScreenState createState() => _OrganisationScreenState();
}

class _OrganisationScreenState extends State<OrganisationScreen> {
  late ApiService apiService;
  List<Organisation>? organisations; // Store organisations here

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchOrganisations(); // Fetch organisations on init
  }

  final String baseUrl = "http://localhost:8000";

  Future<String> changeStatusOfOrganisation(int orgId, String newStatus) async {
    final Uri url = Uri.parse("$baseUrl/organisation/status/$orgId/");
    final response = await http.patch(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"new_status": newStatus}),
    );

    if (response.statusCode == 200) {
      return "Status changed successfully";
    } else {
      throw Exception('Failed to change status of organisation');
    }
  }

  // Fetch organisations only once
  Future<void> fetchOrganisations() async {
    try {
      final List<Organisation> fetchedOrganisations = await apiService.getAllOrganisations();
      setState(() {
        organisations = fetchedOrganisations;
      });
    } catch (error) {
      print("Error fetching organisations: $error");
    }
  }

  Widget _buildDataTable() {
    if (organisations == null) {
      // Handle loading state
      return Center(child: CircularProgressIndicator());
    } else if (organisations!.isEmpty) {
      // Handle empty state
      return Center(child: Text("No organisations found"));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          columns: [
            DataColumn(label: Text('Id')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Start Date')),
            DataColumn(label: Text('End Date')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')), 
            DataColumn(label: Text('   ')),// Add a column for the ToggleButton
          ],
          rows: organisations!.map((organisation) {
            bool isActivated = organisation.status == 'active'; // Check the status of the organisation
            return DataRow(
              cells: [
                DataCell(Text(organisation.orgId.toString())),
                DataCell(Text(organisation.orgName)),
                DataCell(Text(organisation.orgCode)),
                DataCell(Text(organisation.orgStartDate.toString())),
                DataCell(Text(organisation.orgEndDate.toString())),
                DataCell(
                  Text(organisation.status),
                  // Use the isActivated variable to set the color
                  // Green for active, Red for inactive
                ),
                DataCell(
                  ToggleButtons(
                    children: <Widget>[
                      Icon(Icons.check_circle, color: isActivated ? Colors.green : Colors.grey),
                      Icon(Icons.cancel, color: !isActivated ? Colors.red : Colors.grey),
                    ],
                    isSelected: [isActivated, !isActivated], 
                    onPressed: (int newIndex) async {
                    
                      String newStatus = newIndex == 0 ? 'active' : 'inactive';
                      try {
                        // Call the method to change the status
                        String result = await changeStatusOfOrganisation(organisation.orgId, newStatus);
                        if (result == "Status changed successfully") {
                      
                          setState(() {
                            // Update only the status of the specific organisation
                            organisation.status = newStatus;
                          });
                        } else {
                          // Handle failure
                          // You can show an error message or take appropriate action
                        }
                      } catch (e) {
                        // Handle exception
                        // You can show an error message or take appropriate action
                      }
                    },
                  ),
                ),
                   DataCell(
                TextButton(
                  onPressed: () {
                    // Navigate to the NextScreen and pass the orgId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextScreen(orgId: organisation.orgId),
                      ),
                    );
                  },
                  child: Text("Click Here"),
                ),
              ),
              ],
            );
          }).toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Organisation List'),
        ),
        body: _buildDataTable(),
      ),
    );
  }
}


