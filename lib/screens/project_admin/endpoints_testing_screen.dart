
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/main.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_apitestingscreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_homescreen.dart';
import 'package:provider/provider.dart';

class EndpointsScreen extends StatelessWidget {
  const EndpointsScreen({super.key});

  // final List<String> endpoints;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ScreenState>(context).userData;
    final List<String> endpoints = userData['endpoints'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an API Endpoint'),
      ),
      body: ListView.builder(
        itemCount: endpoints.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(endpoints[index]),
            onTap: () {
              // Handle selection of the endpoint, perform any desired action
            },
          );
        },
      ),
    );
  }
}
