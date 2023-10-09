import 'package:harbinger_flutter/models/user_model.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:harbinger_flutter/utils/constants.dart';
import 'dart:convert';

class AuthService {
  final String baseUrl = AppConstants.BASE_URL;

  //login user
  Future<String?> login(String emailId, String password) async {
    final Uri url = Uri.parse("$baseUrl/user/login");

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'email_id': emailId,
          'password': password,
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final String? token = responseData['token'];

      MySharedPref.setToken(token);

      final tokenData = jsonDecode(
          ascii.decode(base64.decode(base64.normalize(token!.split(".")[1]))));

      final String role = tokenData['role'];

      return role;
    } else if (response.statusCode == 401) {
      throw Exception("Invalid credentials");
    } else {
      // Handle other error cases here.
      throw Exception("Failed to log in");
    }
  }

  //register user
  Future<dynamic> register(User user) async {
    final Uri url = Uri.parse("$baseUrl/user/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: userToJson(user),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create organisation');
    }
    return response;
  }
}
