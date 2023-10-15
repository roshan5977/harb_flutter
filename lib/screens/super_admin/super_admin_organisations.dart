import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/screens/super_admin/moreinfo_screen_model.dart';

import 'package:harbinger_flutter/services/organisation_service.dart';
import 'package:http/http.dart' as http;

class AdminOrganisationScreen extends StatelessWidget {
  const AdminOrganisationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrganisationScreen(),
    );
  }
}

class OrganisationScreen extends StatefulWidget {
  const OrganisationScreen({super.key});

  @override
  _OrganisationScreenState createState() => _OrganisationScreenState();
}

class _OrganisationScreenState extends State<OrganisationScreen> {
  late ApiService apiService;
  List<Organisation>? organisations;
  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchOrganisations();
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
      final List<Organisation> fetchedOrganisations =
          await apiService.getAllOrganisations();
      setState(() {
        organisations = fetchedOrganisations;
      });
    } catch (error) {
      print("Error fetching organisations: $error");
    }
  }

  Color cardBackgroundColor = Colors.white;
  Color cardTextColor = const Color.fromARGB(255, 0, 0, 0); // Dark Gray

  Widget _buildDataTable() {
    // Define breakpoints for different screen sizes
    const double smallScreenSize = 640;
    const double mediumScreenSize = 960;
    const double largeScreenSize = 1280;

    // Determine the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the number of columns based on screen size
    int columnsCount = 2; // Default for very small screens

    if (screenWidth >= smallScreenSize && screenWidth < mediumScreenSize) {
      columnsCount = 3; // 3 columns for small screens
    } else if (screenWidth >= mediumScreenSize &&
        screenWidth < largeScreenSize) {
      columnsCount = 4; // 4 columns for medium screens
    } else if (screenWidth >= largeScreenSize) {
      columnsCount = 5; // 5 columns for large screens
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnsCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: organisations!.length,
        itemBuilder: (context, index) {
          final organisation = organisations![index];
          bool isActivated = organisation.status == 'active';
          Color cardColor = isActivated ? Colors.green : Colors.red;

          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color:
                cardBackgroundColor, // Use Light Blue as the card background color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID: ${organisation.orgId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cardTextColor, // Use Dark Gray for text color
                          fontSize: 18, // Increase font size
                        ),
                      ),
                      Text(
                        'Status: ${organisation.status}',
                        style: TextStyle(
                          color: cardTextColor, // Use Dark Gray for text color
                          fontSize: 16, // Increase font size
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Name: ${organisation.orgName}',
                    style: TextStyle(
                      color: cardTextColor, // Use Dark Gray for text color
                      fontSize: 16, // Increase font size
                    ),
                  ),
                  Text(
                    'Code: ${organisation.orgCode}',
                    style: TextStyle(
                      color: cardTextColor, // Use Dark Gray for text color
                      fontSize: 16, // Increase font size
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          String newStatus =
                              isActivated ? 'inactive' : 'active';
                          try {
                            String result = await changeStatusOfOrganisation(
                                organisation.orgId, newStatus);
                            if (result == "Status changed successfully") {
                              setState(() {
                                organisation.status = newStatus;
                              });
                            } else {}
                          } catch (e) {}
                        },
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: isActivated ? Colors.green : Colors.red,
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: isActivated ? 0 : 30,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NextScreen(orgId: organisation.orgId),
                            ),
                          );
                        },
                        child: const Text(
                          "Click Here",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Increase font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget _buildDataTable() {
  //   if (organisations == null) {
  //     // Handle loading state
  //     return const Center(child: CircularProgressIndicator());
  //   } else if (organisations!.isEmpty) {
  //     // Handle empty state
  //     return const Center(child: Text("No organisations found"));
  //   } else {
  //     return Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: DataTable(
  //         columns: const [
  //           DataColumn(label: Text('Id')),
  //           DataColumn(label: Text('Name')),
  //           DataColumn(label: Text('Code')),
  //           DataColumn(label: Text('Start Date')),
  //           DataColumn(label: Text('End Date')),
  //           DataColumn(label: Text('Status')),
  //           DataColumn(label: Text('Actions')),
  //           DataColumn(label: Text('   ')), // Add a column for the ToggleButton
  //         ],
  //         rows: organisations!.map((organisation) {
  //           bool isActivated = organisation.status ==
  //               'active'; // Check the status of the organisation
  //           return DataRow(
  //             cells: [
  //               DataCell(Text(organisation.orgId.toString())),
  //               DataCell(Text(organisation.orgName)),
  //               DataCell(Text(organisation.orgCode)),
  //               DataCell(Text(organisation.orgStartDate.toString())),
  //               DataCell(Text(organisation.orgEndDate.toString())),
  //               DataCell(
  //                 Text(organisation.status),
  //                 // Use the isActivated variable to set the color
  //                 // Green for active, Red for inactive
  //               ),
  //               DataCell(
  //                 ToggleButtons(
  //                   isSelected: [isActivated, !isActivated],
  //                   onPressed: (int newIndex) async {
  //                     String newStatus = newIndex == 0 ? 'active' : 'inactive';
  //                     try {
  //                       // Call the method to change the status
  //                       String result = await changeStatusOfOrganisation(
  //                           organisation.orgId, newStatus);
  //                       if (result == "Status changed successfully") {
  //                         setState(() {
  //                           organisation.status = newStatus;
  //                         });
  //                       } else {}
  //                     } catch (e) {}
  //                   },
  //                   children: <Widget>[
  //                     Icon(Icons.check_circle,
  //                         color: isActivated ? Colors.green : Colors.grey),
  //                     Icon(Icons.cancel,
  //                         color: !isActivated ? Colors.red : Colors.grey),
  //                   ],
  //                 ),
  //               ),
  //               DataCell(
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) =>
  //                             NextScreen(orgId: organisation.orgId),
  //                       ),
  //                     );
  //                   },
  //                   child: const Text("Click Here"),
  //                 ),
  //               ),
  //             ],
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildDataTable(),
      ),
    );
  }
}
