import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harbinger_flutter/screens/org_admin/org_admin_homescreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_homescreen.dart';
import 'package:harbinger_flutter/screens/project_member/project_member_homescreen.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_homescreen.dart';
import 'package:harbinger_flutter/services/auth_service.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';
import 'package:lottie/lottie.dart';

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
              return const LoginContainer();
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
              return const LoginContainer();
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20), // Adjust the radius for rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Carousel(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: const Color.fromARGB(255, 196, 198, 187),
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
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 1, top: 0),
                              //   child: Image.asset(
                              //     'images/l.png',
                              //     width: 150, // Adjust the width as needed
                              //     height: 70, // Adjust the height as needed
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 26),
                                child: Container(
                                  child: Text(
                                    'Harbinger',
                                    style: GoogleFonts.raleway(
                                      textStyle: const TextStyle(
                                        color: Color(0xFF384289),
                                        fontSize: 39,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // const SizedBox(height: 50),
                         
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
                                            Navigation.navigateToHarbingerHome(
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
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255,
                                                      198,
                                                      89,
                                                      101), // Background color
                                              duration: const Duration(
                                                  seconds:
                                                      3), // Duration to show the SnackBar
                                              elevation: 6, // Shadow elevation
                                              behavior: SnackBarBehavior
                                                  .floating, // Floating SnackBar style
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Rounded corners
                                              ),
                                              action: SnackBarAction(
                                                label: 'OK',
                                                textColor: Colors.white,
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
                                    Color.fromARGB(255, 131, 135, 165),
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
                        color: Color(0xFF384289),
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

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const autoScrollDuration = Duration(seconds: 7);
  List<String> animationAssets = [
    'images/animation1.json',
    'images/animation2.json',
    'images/animation3.json',
  ];

  @override
  void initState() {
    super.initState();
     _startAutoScroll();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

    void _startAutoScroll() {
    Future.delayed(autoScrollDuration, _scrollToNextPage);
  }

  void _scrollToNextPage() {
    if (_currentPage < animationAssets.length - 1) {
      _pageController.animateToPage(_currentPage + 1,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      // If it's the last page, go back to the first page
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
    _startAutoScroll(); // Start the auto-scroll again
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .44,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: PageView.builder(
              controller: _pageController,
              itemCount: animationAssets.length,
              itemBuilder: (context, index) {
                return CarouselItem(animationAssets[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                animationAssets.length,
                (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 8,
                    width: (index == _currentPage) ? 24 : 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: (index == _currentPage)
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.5),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String animationAsset;

  const CarouselItem(this.animationAsset, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Lottie.asset(animationAsset),
      ),
    );
  }
}

// class LoginContainer extends StatelessWidget {
//   const LoginContainer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background Image

//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                   'images/orangecover.jpg'), // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // Elevated LoginScreen
//         Center(
//           child: Container(
//             margin: const EdgeInsets.all(46.0),
//             padding: const EdgeInsets.all(.06),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: const LoginScreen(), // Replace with your LoginScreen widget
//           ),
//         ),
//       ],
//     );
//   }
// }

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/orangecover.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),

          // Background Color
          // Positioned.fill(
          //   child: Container(
          //     color: const Color.fromARGB(
          //         255, 218, 163, 24), // Set your background color
          //   ),
          // ),
          // Elevated LoginScreen
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(116, 38, 116, 38),
              padding: const EdgeInsets.all(0.06),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child:
                  const LoginScreen(), // Replace with your LoginScreen widget
            ),
          ),
        ],
      ),
    );
  }
}
