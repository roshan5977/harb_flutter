import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_add_users.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class CreateOrganisation extends StatefulWidget {
  const CreateOrganisation({super.key});

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
          title: const Text("Success"),
          content: Text("Organization created: $orgName"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddUsers()),
                );
              },
              child: const Text("OK"),
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
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center( // Center the form
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the form horizontally
        children: <Widget>[
          Image.asset(
            'images/org.png',
            width: 500,
            height: double.infinity,
          ),
          Expanded(
  child: Padding(
    padding: const EdgeInsets.all(80.0), // Adjust the padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
  child: Text(
    'Enter Organisation Details',
    style: TextStyle(fontSize: 40,color: Color(0xFFF1E90FF)),
   
  ),
),
        SizedBox(height: 30), // Add spacing between the title and text fields
        TextField(
          controller: _orgNameController,
          decoration: InputDecoration(
            labelText: 'Organization Name',
            // Increase text box size
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
        SizedBox(height: 30), // Add spacing between text fields
        TextField(
          controller: _orgCodeController,
          decoration: InputDecoration(
            labelText: 'Organization Code',
            // Increase text box size
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
        SizedBox(height: 30), // Add spacing between text fields
        TextField(
          controller: _orgDescController,
          decoration: InputDecoration(
            labelText: 'Organization Description',
            // Increase text box size
            contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          ),
        ),
        SizedBox(height: 30), // Add spacing between text fields
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () => _selectStartDate(context),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.calendar_today),
                  Text(
                    _startDate != null ? _startDate.toString() : 'Select Start Date',
                    // Increase text size
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => _selectEndDate(context),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.calendar_today),
                  Text(
                    _endDate != null ? _endDate.toString() : 'Select End Date',
                    // Increase text size
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Center(
  child: ElevatedButton(
    onPressed: _createOrganisation,
    child: const Text('Create Organisation'),
     style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all( Color(0xFFF1E90FF)),
    ),
  ),
)
        
      ],
    ),
  ),
),
     ]) ));
}
}
