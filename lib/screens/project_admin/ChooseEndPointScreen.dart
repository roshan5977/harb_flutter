import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/Endpoint.dart';
import 'package:harbinger_flutter/models/response_model.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_homescreen.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ChooseEndPointScreen extends StatefulWidget {
  const ChooseEndPointScreen({super.key});

  @override
  _ChooseEndPointScreenState createState() => _ChooseEndPointScreenState();
}

class _ChooseEndPointScreenState extends State<ChooseEndPointScreen> {
  Endpoint? selectedEndpoint;
  TextEditingController urlController = TextEditingController();
  TextEditingController baseurlController = TextEditingController();
  int? status=200;
  TextEditingController requestBodyController = TextEditingController();
  TextEditingController responseBodyController = TextEditingController();
  String selectedHttpMethod = 'get'; // Default HTTP method
  List<RequestParameter>? reqbody;
  List<RequestParameter>? queryparam;
  List<RequestParameter>? pathvariable;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ScreenState>(context).userData;
    final List<Endpoint> endpoints = userData['endpoints'];

    return Scaffold(
      body: Row(
        children: [
          // 30% part with list of endpoints
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: endpoints.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Path: ${endpoints[index].path}"),
                    subtitle:
                        Text("HTTP Method: ${endpoints[index].httpMethod}"),
                    onTap: () async {
                      // Define the query parameters
                      Map<String, String> queryParams = {
                        'api_info': endpoints[index].path,
                        'http_method': endpoints[index].httpMethod,
                      };

                      // Encode the query parameters into a query string
                      String queryString =
                          Uri(queryParameters: queryParams).query;

                      // API server URL with query parameters
                      String serverUrl =
                          "http://127.0.0.1:8001/getapiinfo/?$queryString";

                      // Make the API call with the query parameters in the URL
                      final response = await http.post(
                        Uri.parse(serverUrl),
                        headers: {
                          'Content-Type': 'application/json',
                        },
                      );

                      if (response.statusCode == 200) {
                        // Successful response
                        final responseData = json.decode(response.body);

                        // Parse the JSON response into a Dart object using your response model
                        final responseModel =
                            ResponseModel.fromJson(responseData);

                        // Now you can work with the response data as Dart objects
                        print(
                            "Parsed Response Model: ${responseModel.toJson()}");

                        // Example: Accessing reqbody, pathvariable, queryparam, and securityparameters
                        if (responseModel.reqbody != null) {
                          setState(() {
                            String bodystart = "{";
                            String bodyend = "\n}";
                            reqbody = responseModel.reqbody;
                            for (RequestParameter parameter
                                in responseModel.reqbody!) {
                              print(parameter.type);
                              if (parameter.type == 'string') {
                                bodystart +=
                                    '\n"${parameter.name}" : "string",';
                              } else if (parameter.type == 'boolean')
                                bodystart += '\n"${parameter.name}" : true,';
                              else
                                bodystart += '\n"${parameter.name}" : 0,';
                              print("Request Parameter: ${parameter.name}");
                            }
                            bodystart =
                                bodystart.substring(0, bodystart.length - 1);
                            requestBodyController.text = bodystart + bodyend;
                          });
                          for (RequestParameter parameter
                              in responseModel.reqbody!) {
                            print("Request Parameter: ${parameter.name}");
                          }
                        }
                        if (responseModel.pathvariable != null) {
                          setState(() {
                            pathvariable = responseModel.pathvariable;
                          });
                          for (RequestParameter parameter
                              in responseModel.pathvariable!) {
                            print("Path Variable: ${parameter.name}");
                          }
                        }
                        if (responseModel.queryparam != null) {
                          setState(() {
                            queryparam = responseModel.queryparam;
                          });
                          for (RequestParameter parameter
                              in responseModel.queryparam!) {
                            print("Query Parameter: ${parameter.name}");
                          }
                        }
                        if (responseModel.securityparameters != null) {
                          print(
                              "Security Parameters: ${responseModel.securityparameters}");
                        }
                      } else {
                        // Error handling for unsuccessful response
                        print(
                            "API Request failed with status code: ${response.statusCode}");
                        print("API Response: ${response.body}");
                      }
                      setState(() {
                        selectedEndpoint = endpoints[index];
                        print("selectedEndpoint${selectedEndpoint?.path}");
                        print(
                            "selectedEndpoint${selectedEndpoint?.httpMethod}");
                        if (selectedEndpoint != null) {
                          urlController.text = selectedEndpoint!.path;
                          selectedHttpMethod = selectedEndpoint!.httpMethod;
                          // requestBodyController.text = ''; // Clear request body
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // 70% part with Postman-like UI
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                children: [
                  // Navigation bar or method selection
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10.0)), // Border radius
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          // Method selection widget
                          // Display the selected value if available
                          DropdownButton<String>(
                            value: selectedHttpMethod,
                            onChanged: (newValue) {
                              setState(() {
                                selectedHttpMethod = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'get',
                                child: Text('GET'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'post',
                                child: Text('POST'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'put',
                                child: Text('PUT'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'delete',
                                child: Text('DELETE'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'patch',
                                child: Text('PATCH'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child: TextField(
                              controller: baseurlController,
                              decoration:
                                  const InputDecoration(labelText: 'BASEURL'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: urlController,
                              decoration:
                                  const InputDecoration(labelText: 'URL'),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  SpecialColors
                                      .Blue2), // Change to your desired color
                            ),
                            onPressed: () {
                              // Handle the send button click, perform the API request
                              performApiRequest(
                                  selectedHttpMethod,
                                  baseurlController.text + urlController.text,
                                  requestBodyController.text,
                                  urlController.text);
                            },
                            child: const Text('Send'),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 19.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[ Text('status: $status',style: TextStyle(color: SpecialColors.Blue2))],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: requestBodyController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  labelText: 'Request Body',labelStyle: TextStyle(fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: responseBodyController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  labelText: 'Response Body',labelStyle: TextStyle(fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add a function to perform the API request based on the selected HTTP method, URL, and request body
  Future<void> performApiRequest(
      String httpMethod, String url, String requestBody, String path) async {
    if (selectedEndpoint != null) {
      print(
          "Making API request with method: $httpMethod, URL: $url, and request body: $requestBody");

      Map<String, String> queryParams = {
        'method': httpMethod,
        'url': url,
        'path': path
      };
      Map<String, dynamic> parsedreqbody = parseJsonString(requestBody);
      print("parsedreqbody$parsedreqbody");

      String reqBodyJson = jsonEncode(parsedreqbody);
      // Encode the query parameters into a query string
      String queryString = Uri(queryParameters: queryParams).query;

      String serverUrl = "http://127.0.0.1:8001/makerequest/?$queryString";

      // Make the API call with the query parameters in the URL
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: reqBodyJson,
      );

      if (response.statusCode == 200) {
        // Successful response
        final responseData = json.decode(response.body);
        print(responseData['respose body']);
        print(responseData['status']);
        setState(() {
          responseBodyController.text = responseData['respose body'];
          status = responseData['status'];
        });
        
      } else {}
    }
  }
}

Map<String, dynamic> parseJsonString(String jsonString) {
  try {
    final Map<String, dynamic> parsedJson = json.decode(jsonString);
    return parsedJson;
  } catch (e) {
    print('Error parsing JSON: $e');
    return <String, dynamic>{};
  }
}
