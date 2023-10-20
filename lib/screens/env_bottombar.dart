import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/services/api_service.dart';
import 'package:harbinger_flutter/utils/constants.dart';

class EnvScreen extends StatefulWidget {
  const EnvScreen({super.key});

  @override
  _EnvScreenState createState() => _EnvScreenState();
}

class _EnvScreenState extends State<EnvScreen> {
  final ApiService apiService = ApiService();
  String gitVersion = '';
  String pythonVersion = '';
  String macId = '';
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
       
        BottomNavigationBarItem(
          icon: const Icon(Icons.label),
          label: 'gitVersion: $gitVersion',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.code),
          label: 'pythonVersion:$pythonVersion',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.computer),
          label: 'Mac ID: $macId',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              fetchData();
            },
          ),
          label: 'refresh',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: SpecialColors.Blue2,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    );
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8000/env/check/'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          gitVersion = data['git_info']['git_version'];
          pythonVersion = data['python_info']['python_version'];
          macId = data['mac_id'];
          dataLoaded = true;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
