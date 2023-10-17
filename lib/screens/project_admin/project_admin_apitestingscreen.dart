import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApiTestingProjectAdmin extends StatelessWidget {
  const ApiTestingProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: FileUploadScreen()));
  }
}

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(FontAwesomeIcons.cloudUploadAlt, size: 160.0),
            SizedBox(
              height: 20,
            ),
            const Text(
                "Upload the project openapi.json file to start API testing",
                style: TextStyle(fontSize: 40)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final file = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );
                if (file != null) {
                  print(file);
                  //make ur call here
                }
              },
              child: const Text("Choose .json file"),
            ),
          ],
        ),
      ),
    );
  }
}
