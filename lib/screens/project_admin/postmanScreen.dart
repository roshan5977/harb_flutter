import 'package:flutter/material.dart';

class PostManScreen extends StatefulWidget {
  const PostManScreen({super.key});

  @override
  _PostManScreenState createState() => _PostManScreenState();
}

class _PostManScreenState extends State<PostManScreen> {
  String requestUrl = '';
  String requestMethod = 'GET';
  String requestBody = '';
  String response = '';

  void sendRequest() {
    // Implement API request logic here and update the 'response' state.
    // You can use packages like http or dio for making HTTP requests.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostMan Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Request URL'),
              onChanged: (value) {
                setState(() {
                  requestUrl = value;
                });
              },
            ),
            DropdownButton<String>(
              value: requestMethod,
              onChanged: (value) {
                setState(() {
                  requestMethod = value!;
                });
              },
              items: <String>['GET', 'POST', 'PUT', 'DELETE'].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Request Body'),
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  requestBody = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: sendRequest,
              child: const Text('Send Request'),
            ),
            const SizedBox(height: 20),
            const Text('Response:'),
            Expanded(
              child: SingleChildScrollView(
                child: Text(response),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
