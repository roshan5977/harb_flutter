// import 'package:flutter/material.dart';
// import 'package:harbinger_flutter/services/organisation_service.dart';

// class OrganizationListPage extends StatefulWidget {
//   @override
//   _OrganizationListPageState createState() => _OrganizationListPageState();
// }

// class _OrganizationListPageState extends State<OrganizationListPage> {
//   late List<dynamic> organizations; // List to store fetched organizations

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch data when the widget is initialized
//   }

//   Future<void> fetchData() async {
//     try {
//       final data = await  ApiService().getAllData();
//       setState(() {
//         organizations = data;
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Organization List'),
//       ),
//       body: organizations == null
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: organizations.length,
//               itemBuilder: (context, index) {
//                 final organization = organizations[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text(organization['name']),
//                     subtitle: Text(organization['description']),
//                     trailing: IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         // Navigate to the edit page for the selected organization
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => EditOrganizationPage(
//                               organization: organization,
//                               fetchData: fetchData, // Pass the fetchData function
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

// class EditOrganizationPage extends StatefulWidget {
//   final Map<String, dynamic> organization;
//   final Function fetchData; // Function to trigger data fetch

//   EditOrganizationPage({required this.organization, required this.fetchData});

//   @override
//   _EditOrganizationPageState createState() => _EditOrganizationPageState();
// }

// class _EditOrganizationPageState extends State<EditOrganizationPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.organization['name'];
//     descriptionController.text = widget.organization['description'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Organization'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextFormField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 final updatedOrganization = {
//                   'id': widget.organization['id'],
//                   'name': nameController.text,
//                   'description': descriptionController.text,
//                 };
//                 try {
//                   // Update the organization using the API service
//                   await Organization_Apiservice()
//                       .updateData(widget.organization['id'], updatedOrganization);

//                   // Trigger data fetch after update
//                   widget.fetchData();

//                   // Return to the previous screen
//                   Navigator.of(context).pop();
//                 } catch (e) {
//                   print('Error updating organization: $e');
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

