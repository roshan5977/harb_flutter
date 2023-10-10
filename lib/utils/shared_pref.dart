import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:flutter/widgets.dart';

class MySharedPref extends StatelessWidget {
  const MySharedPref({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // Verify if the token is valid
  static Future<bool> isLoggedin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("token");

    if (token != null) {
      final tokenData = jsonDecode(
          ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));
      final int expirySeconds = tokenData['exp'];
      final String role = tokenData['role'];
      //seting the role
      sharedPreferences.setString("role", role);

      // Get the current time in seconds since the epoch
      final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Check if the token is expired
      if (currentTime < expirySeconds) {
        return true; // Token is valid
      } else {
        sharedPreferences.remove("token"); //expired token removed.
      }
    }
    return false; // Token is invalid or not found
  }

  static setToken(token) async {
    await SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setString("token", token);
    });
  }

  static Future<String?> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("token");
    return token;
  }
   static Future<String?> getRole() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final role = sharedPreferences.getString("role");
    return role;
  }

  // static setUser(User user) async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   final userJson = jsonEncode(
  //       user.toJson()); // Assuming your User model has a toJson() method.
  //   sharedPreferences.setString("user", userJson);
  // }

  // static Future<User?> getUser() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   final userJson = sharedPreferences.getString("user");
  //   if (userJson != null) {
  //     final Map<String, dynamic> userMap = jsonDecode(userJson);
  //     final User user = User.fromJson(
  //         userMap); // Assuming your User model has a fromJson() constructor.
  //     return user;
  //   }
  //   return null;
  // }
}




// encode
// Future<dynamic> getData(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   final encodedData = prefs.getString(key);
//   if (encodedData != null) {
//     return jsonDecode(encodedData);
//   }
//   return null;
// }

// decode
// Future<void> storeData(String key, dynamic data) async {
//   final prefs = await SharedPreferences.getInstance();
//   final encodedData = jsonEncode(data);
//   await prefs.setString(key, encodedData);
// }
