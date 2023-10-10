import 'package:flutter/material.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_add_users.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: CreateOrganisation(),
  ));
}

class CreateOrganisation extends StatefulWidget {
  const CreateOrganisation({Key? key}) : super(key: key);

  @override
  State<CreateOrganisation> createState() => _CreateOrganisationState();
}

class _CreateOrganisationState extends State<CreateOrganisation> {
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _orgCodeController = TextEditingController();
  final TextEditingController _orgDescController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  XFile? _selectedImage;

  @override
  void dispose() {
    _orgNameController.dispose();
    _orgCodeController.dispose();
    _orgDescController.dispose();
    super.dispose();
  }

  void _saveAndPrint() {
    final orgName = _orgNameController.text;
    final orgCode = _orgCodeController.text;
    final orgDesc = _orgDescController.text;

    print('Organization Name: $orgName');
    print('Organization Code: $orgCode');
    print('Organization Description: $orgDesc');
    print('Start Date: $_startDate');
    print('End Date: $_endDate');
    if (_selectedImage != null) {
      print('Selected Image Path: ${_selectedImage!.path}');
    }

    // Show an alert dialog to confirm saving the details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Save'),
          content: Text('Do you want to save the organisation details?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the alert dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the details and close the alert dialog
                // You can add your save logic here

                // Navigate to the "addusers" page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddUsers(),
                  ),
                );

               // Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
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
        padding: EdgeInsets.all(40.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'images/org.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _orgNameController,
                      decoration: InputDecoration(labelText: 'Enter Organization Name'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _orgCodeController,
                      decoration: InputDecoration(labelText: 'Enter Organization Code'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _orgDescController,
                      decoration: InputDecoration(labelText: 'Enter Organization Description'),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20), // Add margin to create spacing
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                            Text('Upload Company Logo', textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Add space here
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => _selectStartDate(context),
                                child: AbsorbPointer(
                                  child: TextField(
                                    controller: TextEditingController(text: _startDate?.toLocal().toString().split(' ')[0] ?? ''),
                                    decoration: InputDecoration(labelText: 'Select Start Date'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => _selectEndDate(context),
                                child: AbsorbPointer(
                                  child: TextField(
                                    controller: TextEditingController(text: _endDate?.toLocal().toString().split(' ')[0] ?? ''),
                                    decoration: InputDecoration(labelText: 'Select End Date'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20), // Add space here
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveAndPrint,
                        child: Text('Save Organisation'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

