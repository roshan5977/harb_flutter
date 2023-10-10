import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class NextScreen extends StatefulWidget {
  final int orgId;

  NextScreen({required this.orgId});

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
      return organisationData;
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Organisation"),
      ),
      body: Center(
        child: FutureBuilder<Organisationremodel>(
          future: _organisationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while fetching data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle error state
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the fetched data directly
              final organisationData = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Organization Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(organisationData.orgName),
                      SizedBox(height: 16.0),
                      Text(
                        'Organization Code:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(organisationData.orgCode),
                      SizedBox(height: 16.0),
                      Text(
                        'Description:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(organisationData.orgDesc),
                      SizedBox(height: 16.0),
                      Text(
                        'Start Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(organisationData.orgStartDate.toString()),
                      SizedBox(height: 16.0),
                      Text(
                        'End Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(organisationData.orgEndDate.toString()),
                      SizedBox(height: 24.0),
                      Text(
                        'Organisation Admins:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Display organisation admins here
                        children: organisationData.orgAdmins.map((admin) {
                          return Text(admin.emailId ?? 'N/A');
                        }).toList(),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        'Project Admins:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Display project admins here
                        children: organisationData.projectAdmins.map((admin) {
                          return Text(admin.emailId ?? 'N/A');
                        }).toList(),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        'Project Members:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
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
      ),
    );
  }
}
