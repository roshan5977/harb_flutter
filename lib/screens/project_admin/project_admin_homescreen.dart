import 'package:flutter/material.dart';
import 'package:harbinger_flutter/main.dart';
import 'package:harbinger_flutter/models/organisation_remodel.dart';
import 'package:harbinger_flutter/screens/env_bottombar.dart';
import 'package:harbinger_flutter/screens/login_screen.dart';
import 'package:harbinger_flutter/screens/project_admin/ChooseEndPointScreen.dart';
import 'package:harbinger_flutter/screens/project_admin/endpoints_testing_screen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_apitestingscreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_projectscreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_reportscreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_testplanscreen.dart';
import 'package:harbinger_flutter/screens/project_admin/project_admin_workspacescreen.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:harbinger_flutter/utils/shared_pref.dart';
import 'package:provider/provider.dart';

enum AppThemeMode { light, dark }

class ScreenState extends ChangeNotifier {
  String _currentScreen = 'workspace';
  Map<String, dynamic> _userData = {};

  String get currentScreen => _currentScreen;
  Map<String, dynamic> get userData => _userData;

  void changeScreen(String screen, {Map<String, dynamic>? data}) {
    _currentScreen = screen;
    if (data != null) {
      _userData = data;
    }
    notifyListeners();
  }
}

class ProjectAdminHarbinger extends StatelessWidget {
  const ProjectAdminHarbinger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MaterialApp(
        home: ProjectAdminHomeScreen(),
      ),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    );
  }
}

class ProjectAdminHomeScreen extends StatefulWidget {
  const ProjectAdminHomeScreen({Key? key}) : super(key: key);

  @override
  _ProjectAdminHomeScreenState createState() => _ProjectAdminHomeScreenState();
}

class _ProjectAdminHomeScreenState extends State<ProjectAdminHomeScreen> {
  int _selectedIndex = 0;
  AppThemeMode _currentThemeMode = AppThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _currentThemeMode = _currentThemeMode == AppThemeMode.light
          ? AppThemeMode.dark
          : AppThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = _currentThemeMode == AppThemeMode.light
        ? ThemeData.light()
        : ThemeData.dark();

    final screenState = Provider.of<ScreenState>(context);

    Widget content = const WorkspaceScreenProjectAdmin();
    if (screenState.currentScreen == 'workspace') {
      content = const WorkspaceScreenProjectAdmin();
    } else if (screenState.currentScreen == 'project') {
      content = const ProjectScreenProjectAdmin();
    } else if (screenState.currentScreen == 'testplan') {
      content = const ProjectAdminTestPlan();
    } else if (screenState.currentScreen == 'reports') {
      content = const ProjectAdminReportScreen();
    } else if (screenState.currentScreen == 'apitesting') {
      content = const ApiTestingProjectAdmin();
    } else if (screenState.currentScreen == 'endpoint') {
      content = const ChooseEndPointScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: SpecialColors.Blue2,
          title: const Center(
            child: Text(
              "Project Admin",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                _currentThemeMode == AppThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                _toggleTheme();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () {
                _handleLogout(); // Call the logout function when the logout button is pressed
              },
            ),
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: const Color.fromARGB(255, 245, 245, 247),
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon:
                          Icon(Icons.add_home_work_sharp, color: Colors.white),
                      label: 'Workspace'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.feed, color: Colors.white),
                      label: 'Project'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.view_agenda, color: Colors.white),
                      label: 'TestPlan'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.report, color: Colors.white),
                      label: 'Reports'),
                  BottomNavigationBarItem(
                      icon:
                          Icon(Icons.developer_mode_sharp, color: Colors.white),
                      label: 'ApiTesting'),
                ],
              )
            : const EnvScreen(),
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                backgroundColor: SpecialColors.Blue2,
                selectedIndex: _getSelectedIndex(screenState.currentScreen),
                onDestinationSelected: (int index) {
                  String route = 'workspace';
                  if (index == 0) {
                    route = 'workspace';
                  } else if (index == 1) {
                    route = 'project';
                  } else if (index == 2) {
                    route = 'testplan'; // Update with your route names
                  } else if (index == 3) {
                    route = 'reports'; // Update with your route names
                  } else if (index == 4) {
                    route = 'apitesting'; // Update with your route names
                  }
                  Provider.of<ScreenState>(context, listen: false)
                      .changeScreen(route);
                },
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.add_home_work_sharp, color: Colors.white),
                    label: Text('Workspace'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.feed, color: Colors.white),
                    label: Text('Project'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.view_agenda, color: Colors.white),
                    label: Text('Testplan'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.report, color: Colors.white),
                    label: Text('Reports'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.developer_mode_sharp, color: Colors.white),
                    label: Text('ApiTesting'),
                  ),
                  // NavigationRailDestination(
                  //   icon:Icon(Icons.developer_mode_sharp, color: Colors.white),
                  //     // icon: Column(
                  //     //   children: [
                  //     //     Image.asset('images/feuji.png',
                  //     //         fit: BoxFit.cover, height: 50, width: 70)
                  //     //   ],
                  //     // ),
                  //     label: Text('  k'),
                  //     ),
                ],
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                unselectedLabelTextStyle:
                    const TextStyle(color: Color.fromARGB(255, 133, 167, 190)),
              ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
      theme: currentTheme,
    );
  }

  int _getSelectedIndex(String currentScreen) {
    switch (currentScreen) {
      case 'workspace':
        return 0;
      case 'project':
        return 1;
      case 'testplan':
        return 2; // Update with your route names
      case 'reports':
        return 3; // Update with your route names
      case 'apitesting':
        return 4; // Update with your route names
      default:
        return 0; // You can set a default index if needed
    }
  }

  void _handleLogout() {
    // Clear the user's token or any other necessary data from SharedPreferences
    MySharedPref
        .cleartoken(); // Use the appropriate method from your SharedPreferences handling file

    // Navigate to the LoginScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            const LoginContainer(), // Use the appropriate route or widget for your LoginScreen
      ),
    );
  }
}
