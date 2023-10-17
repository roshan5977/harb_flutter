import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApiTestingProjectAdmin extends StatelessWidget {
  const ApiTestingProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const FileUploadScreen();
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
      appBar: AppBar(
        title: const Text("API Testing App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(FontAwesomeIcons.cloudUploadAlt, size: 100.0),
            const Text("Upload a .json file to start API testing"),
            ElevatedButton(
              onPressed: () async {
                final file = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );
                if (file != null) {
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
