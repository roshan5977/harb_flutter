import 'package:flutter/material.dart';
import 'package:harbinger_flutter/workspace.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Harbinger',
      home: LoginScreen(),
    );
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _navigateToHarbinger(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Harbinger(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Color.fromARGB(255, 199, 230, 238),
        body: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(130, 50, 40, 0),
                        child: Text(
                          'Your own automation copilot',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF384289),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Container(
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
                      offset: Offset(0, 3),
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
                            
                          
                            SizedBox(height: 20),
                            Text(
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
                      SizedBox(height: 20),
                      _buildInputField(
                        labelText: 'Username',
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: 20),
                      _buildInputField(
                        labelText: 'Password',
                        icon: Icons.password,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _navigateToHarbinger(context); // Navigate to Harbinger class
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 174, 189, 227),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF384289),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Do not have a login ID? Please reach out to us at",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      Text(
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
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Color(0xFF384289)),
        prefixIcon: icon != null ? Icon(icon, color: Color(0xFF384289)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
