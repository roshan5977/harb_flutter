import 'package:flutter/material.dart';
import 'package:harbinger_flutter/routes/app_routes.dart';
import 'package:harbinger_flutter/screens/org_admin/org_admin_homescreen.dart';

import 'package:harbinger_flutter/screens/project_admin/project_admin_homescreen.dart';
import 'package:harbinger_flutter/screens/project_member/project_member_homescreen.dart';

import 'package:harbinger_flutter/screens/super_admin/super_admin_homescreen.dart';

import 'package:harbinger_flutter/services/auth_service.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  String role = "";
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final isLoggedIn = await MySharedPref.isLoggedin();
    print(isLoggedIn);
    if (isLoggedIn) {
      final gettingrole = await MySharedPref.getRole();
      if (gettingrole != null) {
        role = gettingrole;
      }
      print("printing role");
      Navigation.navigateToHarbingerHome(context, role);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Harbinger',

        //check the  shared pref if logged in  then check the role and traverse .
        routes: {
          '/': (context) {
            if (role.isEmpty) {
              return const LoginScreen();
            } else if (role == AppRoles.superAdmin) {
              return const SuperAdminHomeScreen();
            } else if (role == AppRoles.orgAdmin) {
              return const OrgAdminHomeScreen();
            } else if (role == AppRoles.projectAdmin) {
              return const ProjectAdminHomeScreen();
            } else if (role == AppRoles.projectMember) {
              return const ProjectMemberHomeScreen();
            } else {
              // Handle invalid roles or other cases
              return const LoginScreen();
            }
          }
        });
  }
}

class AppRoles {
  static const superAdmin = 'superadmin';
  static const orgAdmin = 'org_admin';
  static const projectAdmin = 'project_admin';
  static const projectMember = 'project_member';
}

class Navigation {
  static void navigateToHarbingerHome(BuildContext context, String role) {
    print("Welcome $role");
    switch (role) {
      case AppConstants.SUPERADMIN:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SuperAdminHomeScreen(),
          ),
        );
        break;
      case AppConstants.ORGADMIN:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const OrgAdminHomeScreen(),
          ),
        );
        break;
      case AppConstants.PROJECTADMIN:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProjectAdminHomeScreen(),
          ),
        );
        break;
      case AppConstants.PROJECTMEMBER:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProjectMemberHomeScreen(),
          ),
        );
        break;
      default:
        // Invalid role
        ErrorMessageHandler.showInvalidRoleMessage(context);
        break;
    }
  }
}

class ErrorMessageHandler {
  static void showInvalidRoleMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Invalid email or password.'),
      duration: Duration(seconds: 3),
    ));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
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
                  padding: const EdgeInsets.only(left: 27.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(190, 80, 40, 0),
                        child: Text(
                          'Your own automation copilot',
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF384289),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 95),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.6,
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
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(100, 100, 100, 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 1, top: 0),
                                  child: Image.asset(
                                    'images/l.png',
                                    width: 150, // Adjust the width as needed
                                    height: 70, // Adjust the height as needed
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 102, top: 26),
                                  child: Container(
                                    child: const Text(
                                      'arbinger',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 23, 141, 180),
                                          fontSize: 39),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // const SizedBox(height: 50),
                            const Text(
                              '',
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
                      Form(
                          key: _formKey,
                          // autovalidateMode:
                          //     AutovalidateMode.onUserInteraction, // A
                          child: Column(
                            children: [
                              _buildInputField(
                                labelText: 'Email',
                                icon: Icons.email_outlined,
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  } else if (!value.contains('@')) {
                                    return 'Invalid email format';
                                  }
                                  return null;
                                },
                                showError: _emailController.text.isNotEmpty,
                              ),
                              const SizedBox(height: 20),
                              _buildInputField(
                                labelText: 'Password',
                                icon: Icons.lock,
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                                showError: _passwordController.text.isNotEmpty,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _isFormValid
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          final email = _emailController.text;
                                          final password =
                                              _passwordController.text;
                                          print("sending azax");
                                          String? role;
                                          try {
                                            role = await AuthService()
                                                .login(email, password);
                                            if (role != null) {
                                              Navigation
                                                  .navigateToHarbingerHome(
                                                      context, role);
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                width: 300,
                                                content: const Text(
                                                  'Invalid email or password.',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Text color
                                                    fontSize: 16, // Text size
                                                  ),
                                                ),
                                                backgroundColor: const Color
                                                    .fromARGB(255, 117, 183,
                                                    205), // Background color
                                                duration: const Duration(
                                                    seconds:
                                                        3), // Duration to show the SnackBar
                                                elevation:
                                                    6, // Shadow elevation
                                                behavior: SnackBarBehavior
                                                    .floating, // Floating SnackBar style
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10), // Rounded corners
                                                ),
                                                action: SnackBarAction(
                                                  label: 'OK',
                                                  onPressed: () {
                                                    // Action to take when the "OK" button is pressed
                                                  },
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 174, 204, 214),
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
                                    color: Color.fromARGB(255, 10, 135, 177),
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )),
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
    String? Function(String?)? validator,
    bool showError = false, // Add a parameter to control error display
  }) {
    final errorText = showError
        ? (validator != null ? validator(controller!.text) : null)
        : null;
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFF384289)),
        prefixIcon:
            icon != null ? Icon(icon, color: const Color(0xFF384289)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: errorText,
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
