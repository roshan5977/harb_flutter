import 'package:flutter/material.dart';

import 'package:harbinger_flutter/screens/super_admin/super_admin_createorg.dart';
import 'package:harbinger_flutter/screens/super_admin/super_admin_organisations.dart';
import 'package:harbinger_flutter/screens/super_admin/test.dart';

enum AppThemeMode { light, dark }

class SuperAdminHarbinger extends StatelessWidget {
  const SuperAdminHarbinger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SuperAdminHomeScreen(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
    );
  }
}

class SuperAdminHomeScreen extends StatefulWidget {
  const SuperAdminHomeScreen({Key? key}) : super(key: key);

  @override
  _SuperAdminHomeScreenState createState() => _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends State<SuperAdminHomeScreen> {
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF3752e),
          title: const Center(
            child: Text(
              "Welcome super admin",
              style: TextStyle(color: Colors.black),
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
          ],
        ),
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.indigoAccent,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard), label: 'Dashboard'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Organisation'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.create), label: 'create Organization'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.view_agenda), label: 'Projects'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.analytics), label: 'Analytics'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'settings'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.logout), label: 'logout'),
                ],
              )
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                backgroundColor: const Color(0xFFFF3752e),
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selectedIndex: _selectedIndex,
                destinations: const [

                    NavigationRailDestination(
                    icon: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            'https://example.com/your_profile_image.jpg',
                          ),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                    label: Text('John Doe'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.feed),
                    label: Text('Organisation'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.view_agenda),
                    label: Text('create Organization'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.report),
                    label: Text('Projects'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('Analytics'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('settings'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                  ),
                
                ],
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: const TextStyle(
                  color: Colors.teal,
                ),
                unselectedLabelTextStyle: const TextStyle(),
              ),
            Expanded(
              // This will display the OrganisationScreen content on top
              child: Stack(
                children: [
                  // Display OrganisationScreen content when index is 2
                  if (_selectedIndex == 1) const OrganisationScreen(),
                  // Display CreateOrganisation content when index is 3
                  if (_selectedIndex == 2) const CreateOrganisation(),
                ],
              ),
            ),
          ],
        ),
      ),
      theme: currentTheme,
    );
  }
}
