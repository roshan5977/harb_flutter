import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';

class EditOrganisationScreen extends StatefulWidget {
  final Organisation organisation;
  final Function(Organisation) onSave;

  EditOrganisationScreen({required this.organisation, required this.onSave});

  @override
  _EditOrganisationScreenState createState() => _EditOrganisationScreenState();
}

class _EditOrganisationScreenState extends State<EditOrganisationScreen> {
  late TextEditingController orgNameController;
  late TextEditingController orgCodeController;
  late TextEditingController orgDescController;

  @override
  void initState() {
    super.initState();
    orgNameController = TextEditingController(text: widget.organisation.orgName);
    orgCodeController = TextEditingController(text: widget.organisation.orgCode);
    orgDescController = TextEditingController(text: widget.organisation.orgDesc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Organisation"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveChanges();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: orgNameController,
              decoration: InputDecoration(labelText: "Organisation Name"),
            ),
            TextField(
              controller: orgCodeController,
              decoration: InputDecoration(labelText: "Organisation Code"),
            ),
            TextField(
              controller: orgDescController,
              decoration: InputDecoration(labelText: "Organisation Description"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    
    String updatedName = orgNameController.text;
    String updatedCode = orgCodeController.text;
    String updatedDesc = orgDescController.text;

   
    widget.organisation.orgName = updatedName;
    widget.organisation.orgCode = updatedCode;
    widget.organisation.orgDesc = updatedDesc;

    
    widget.onSave(widget.organisation);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    orgNameController.dispose();
    orgCodeController.dispose();
    orgDescController.dispose();
    super.dispose();
  }
}
