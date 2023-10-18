
import 'package:flutter/material.dart';

class EndpointsScreen extends StatelessWidget {
  final List<String> endpoints;

  EndpointsScreen(this.endpoints);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select an API Endpoint'),
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