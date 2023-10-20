import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/screens/login_screen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_homescreen.dart';
import 'package:harbinger_flutter/screens/projectadmin_screen.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_createorg.dart';
import 'package:provider/provider.dart';
import 'package:harbinger_flutter/utils/interceptor.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ScreenState(),
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());

  final token = await MySharedPref.getToken(); // Retrieve the token
  if (token != null) {
    print("main token$token");
    dio.interceptors
        .add(AuthorizationInterceptor(token)); // Add interceptor with token
  }
}

