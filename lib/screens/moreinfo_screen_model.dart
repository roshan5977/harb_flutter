import 'package:flutter/material.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class NextScreen extends StatelessWidget {
  final int orgId;
  final ApiService apiService = ApiService();

  NextScreen({required this.orgId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Oraganisation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Selected Org ID: $orgId"),
            
          ],
        ),
      ),
    );
  }
}
