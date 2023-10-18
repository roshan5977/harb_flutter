import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harbinger_flutter/models/Endpoint.dart';
import 'package:harbinger_flutter/screens/project_admin/ChooseEndPointScreen.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(FontAwesomeIcons.cloudUploadAlt, size: 160.0),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Upload the project openapi.json file to start API testing",
                  style: TextStyle(fontSize: 40)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      SpecialColors.Blue2, // Change this to the color you want
                ),
                onPressed: () async {
                  print("uploading....");
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['json'],
                  );
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      showSpinner = true;
                    });
                    String serverUrl = "http://127.0.0.1:8001/uploadapiinfo/";
                    final selectedFile = result.files.first;
                    // Create an HTTP request to your backend
                    final request =
                        http.MultipartRequest('POST', Uri.parse(serverUrl));

                    // Convert the Uint8List to List<int>
                    final byteList = selectedFile.bytes!.toList();

                    // Create a Stream from the List<int>
                    final fileStream =
                        Stream<List<int>>.fromIterable([byteList]);
                    // Create a MultipartFile from the selected file
                    final multipartFile = http.MultipartFile.fromBytes(
                        'file', byteList,
                        filename: selectedFile.name);

                    // Add the file to the request
                    request.files.add(multipartFile);

                    // Send the request
                    final response = await request.send();
                    print("response: $response");
                    if (response.statusCode == 200) {
                      //make to next screen and send the data u got
                      setState(() {
                        showSpinner = true;
                      });

                      final List<dynamic> responseData =
                          json.decode(await response.stream.bytesToString());
                      final List<Endpoint> endpoints = responseData
                          .map((e) => Endpoint.fromJson(e))
                          .toList();
                      // Navigate to the ChooseEndPointScreen and pass the 'endpoints' list
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ChooseEndPointScreen(endpoints: endpoints),
                        ),
                      );
                      print('image uploaded');
                    } else {
                      print('failed');
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } else {
                    print("No file selected.");
                  }
                },
                child: const Text("Choose .json file"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
