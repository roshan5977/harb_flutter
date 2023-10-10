import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:harbinger_flutter/screens/login_screen.dart';
import 'package:harbinger_flutter/utils/interceptor.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';

// import 'package:harbinger_flutter/screens/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();

  final token = await MySharedPref.getToken(); // Retrieve the token

  if (token != null) {
    dio.interceptors
        .add(AuthorizationInterceptor(token)); // Add interceptor with token
  }
}
