import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/project_admin_model.dart';
import 'package:harbinger_flutter/screens/org_admin_screen.dart';
import 'package:harbinger_flutter/screens/projectadmin_screen.dart';
import 'package:harbinger_flutter/screens/projectmember_screen.dart';
import 'package:harbinger_flutter/screens/superadmin_screen.dart';
import 'package:harbinger_flutter/services/auth_service.dart';
import 'package:harbinger_flutter/utils/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harbinger',
      //check the  shared pref if logged in  then check the role and traverse .
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToHarbinger(BuildContext context, String role) {
    if (role == AppConstants.SUPERADMIN) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SuperAdminScreen(),
        ),
      );
    } else if (role == AppConstants.ORGADMIN) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OrgAdminScreen(),
        ),
      );
    } else if (role == AppConstants.PROJECTADMIN) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProjectAdminScreen(),
        ),
      );
    } else if (role == AppConstants.PROJECTMEMBER) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProjectMemberScreen(),
        ),
      );
    } else {
      //invalid role
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 199, 230, 238),
        body: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(130, 50, 40, 0),
                        child: Text(
                          'Your own automation copilot',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF384289),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 400,
                          child: Image.asset('images/loginpage.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 600,
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // Added a container to hold the "Harbinger" and "Login" text
                        child: Column(
                          children: [
                            Image.asset(
                              'images/l.png',
                              width: 200, // Adjust the width as needed
                              height: 100, // Adjust the height as needed
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF384289),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        labelText: 'Email',
                        icon: Icons.email_outlined,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        labelText: 'Password',
                        icon: Icons.password,
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;

                          String? role =
                              await AuthService().login(email, password);
                          if (role != null) {
                            _navigateToHarbinger(context, role);
                          }

                          //invalid credentials
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 174, 189, 227),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF384289),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Do not have a login ID? Please reach out to us at",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "harbinger@feuji.com",
                        style: TextStyle(
                          color: Color(0xffFF8303),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String labelText,
    IconData? icon,
    bool obscureText = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF384289)),
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFF384289)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
