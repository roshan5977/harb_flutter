import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/Endpoint.dart';
import 'package:harbinger_flutter/screens/project_admin/postmanScreen.dart';

class ChooseEndPointScreen extends StatelessWidget {
  final List<Endpoint> endpoints;

  const ChooseEndPointScreen({super.key, required this.endpoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Endpoint"),
      ),
      body: ListView.builder(
        itemCount: endpoints.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("Path: ${endpoints[index].path}"),
              subtitle: Text("HTTP Method: ${endpoints[index].httpMethod}"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PostManScreen(),
                  ),
                );
                // Handle the tap event, e.g., perform the API request
                performApiRequest(endpoints[index]);
              },
            ),
          );
        },
      ),
    );
  }

  // Add a function to perform the API request based on the selected endpoint
  void performApiRequest(Endpoint endpoint) {
    print("making api req with endpoint:$endpoint");

    // Perform the API request using the 'endpoint' data
    // You can use the 'path' and 'httpMethod' properties to make the request
  }
}
