import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class ProjectAdminHarbinger extends StatelessWidget {
  const ProjectAdminHarbinger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProjectAdminHomeScreen(),
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 199, 230, 238),
          title: const Center(
            child: Text(
              "Harbinger",
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
                      icon: Icon(Icons.home), label: 'WorkspaceS'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.feed), label: 'ProjectS'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.view_agenda), label: 'TestPlan'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.report), label: 'Reports'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'settings'),
                ],
              )
            : null,
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                backgroundColor: const Color.fromARGB(255, 199, 230, 238),
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selectedIndex: _selectedIndex,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('WorkspaceS'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.feed),
                    label: Text('ProjectS'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.view_agenda),
                    label: Text('Testplan'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.report),
                    label: Text('Reports'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text('settings'),
                  ),
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
                ],
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: const TextStyle(
                  color: Colors.teal,
                ),
                unselectedLabelTextStyle: const TextStyle(),
              ),
          ],
        ),
      ),
      theme: currentTheme,
    );
  }
}
