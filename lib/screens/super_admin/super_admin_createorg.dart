import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';
// Import your API service here
 // Import your Organisation model here

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
      orgStartDate: _startDate!,
      orgEndDate: _endDate!,
      createdOn: DateTime.now(),
      updatedOn: DateTime.now(),
    );

    try {
      final createdOrg = await apiService.createOrganisation(newOrg);
      // Handle the created organization as needed
      print("Created Organization: ${createdOrg.orgName}");
    } catch (e) {
      print("Failed to create organization: $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Organisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: Text(_startDate != null
                  ? 'Start Date: ${_startDate!.toLocal()}'
                  : 'Select Start Date'),
            ),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: Text(_endDate != null
                  ? 'End Date: ${_endDate!.toLocal()}'
                  : 'Select End Date'),
            ),
            ElevatedButton(
              onPressed: _createOrganisation,
              child: Text('Create Organisation'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateOrganisation(),
  ));
}