import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_add_users.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class CreateOrganisation extends StatefulWidget {
  @override
  _CreateOrganisationState createState() => _CreateOrganisationState();
}

class _CreateOrganisationState extends State<CreateOrganisation> {
  final ApiService apiService = ApiService();
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _orgCodeController = TextEditingController();
  final TextEditingController _orgDescController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  void _createOrganisation() async {
    final newOrg = Organisation(
      orgName: _orgNameController.text,
      orgCode: _orgCodeController.text,
      orgDesc: _orgDescController.text,
      orgStartDate: DateTime.now(),
      orgEndDate: DateTime.now(),
      createdOn: DateTime.now(),
      updatedOn: DateTime.now(),
    );

    try {
      final createdOrg = await apiService.createOrganisation(newOrg);
      // Show a custom pop-up dialog for success
      _showSuccessDialog(createdOrg.orgName);
    } catch (e) {
      // Show a custom pop-up dialog for error
      _showErrorDialog("Failed to create organization: $e");
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  // Custom pop-up dialog for success
  void _showSuccessDialog(String orgName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Organization created: $orgName"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddUsers()),
  );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Custom pop-up dialog for error
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Organisation'),
      ),
      body: Row(
        children: <Widget>[
          Image.asset(
            'images/org.png',
            width: 500,
            height: double.infinity,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Enter Organisation Details', style: TextStyle(fontSize: 20)),
                  TextField(
                    controller: _orgNameController,
                    decoration: InputDecoration(labelText: 'Organization Name'),
                  ),
                  TextField(
                    controller: _orgCodeController,
                    decoration: InputDecoration(labelText: 'Organization Code'),
                  ),
                  TextField(
                    controller: _orgDescController,
                    decoration: InputDecoration(labelText: 'Organization Description'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () => _selectStartDate(context),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today),
                            Text(_startDate != null ? _startDate.toString() : 'Select Start Date'),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () => _selectEndDate(context),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today),
                            Text(_endDate != null ? _endDate.toString() : 'Select End Date'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _createOrganisation,
                    child: Text('Create Organisation'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
