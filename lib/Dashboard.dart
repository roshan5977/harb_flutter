import 'package:flutter/material.dart';
import 'package:harbinger_flutter/register_organisation.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrganizationScreen(),
    );
  }
}

class OrganizationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No organizations are available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrganisation(),
      ),
    );
              },
              child: Text('Create Organization'),
            ),
          ],
        ),
      ),
    );
  }
}
// oe