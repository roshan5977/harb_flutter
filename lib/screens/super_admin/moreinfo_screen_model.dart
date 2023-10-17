import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_add_users.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class NextScreen extends StatefulWidget {
  final int orgId;

  const NextScreen({super.key, required this.orgId});

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  late Future<Organisationremodel> _organisationFuture;

  @override
  void initState() {
    super.initState();
    _organisationFuture = _fetchOrganisationData();
  }

  Future<Organisationremodel> _fetchOrganisationData() async {
    try {
      final apiService = ApiService();
      final organisationData =
          await apiService.getOrganisationWithRelations(widget.orgId);
      print("organisationData$organisationData");
      return organisationData;
    } catch (error) {
      print('Error fetching data: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: const Alignment(1.5, -2),
      title: const Text('Organization Details'),
      content: FutureBuilder<Organisationremodel>(
        future: _organisationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while fetching data
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error state
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the fetched data directly
            final organisationData = snapshot.data!;

            return Container(
              width: MediaQuery.of(context).size.width *
                  0.38, // Adjust the height as needed
              height: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Organization Name:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(organisationData.orgName),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Organization Code:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(organisationData.orgCode),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Description:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(organisationData.orgDesc),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Start Date:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(organisationData.orgStartDate.toString()),
                    const SizedBox(height: 20.0),
                    const Text(
                      'End Date:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(organisationData.orgEndDate.toString()),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Organisation Admins:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    TextButton(
                      onPressed: () {
                        _addUsers(2);
                        // Open the modal to add an organization admin
                        // You can implement the modal opening logic here
                      },
                      child: const Text('Add Organisation Admin'),
                    ),
                    const SizedBox(height: 8.0),
                    // Text(organisationData.orgAdmins.toString()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Display organisation admins here

                      children: organisationData.orgAdmins.map((admin) {
                        return Text(admin.emailId.toString() ?? 'N/A');
                      }).toList(),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Project Admins:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    TextButton(
                      onPressed: () {
                        _addUsers(3);
                        // Open the modal to add an organization admin
                        // You can implement the modal opening logic here
                      },
                      child: const Text('Add Project Admin'),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Display project admins here
                      children: organisationData.projectAdmins.map((admin) {
                        return Text(admin.emailId ?? 'N/A');
                      }).toList(),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Project Members:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    TextButton(
                      onPressed: () {
                        _addUsers(4);
                        // Open the modal to add an organization admin
                        // You can implement the modal opening logic here
                      },
                      child: const Text('Add Project Member'),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Display project members here
                      children: organisationData.projectMembers.map((member) {
                        return Text(member.emailId ?? 'N/A');
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _addUsers(roleRefId) {
    String user = "";
    if (roleRefId == 2) {
      user = "Organization Admin";
    } else if (roleRefId == 3)
      user = "Project Admin";
    else if (roleRefId == 3) user = "Project Member";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add $user'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: SizedBox(
            height: 350,
            width: 300,
            child:
                UserRegistrationForm(orgId: widget.orgId, roleRefId: roleRefId),
          ),
        );
      },
    );
  }
}
