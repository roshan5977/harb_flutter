import 'package:flutter/material.dart';

class ProjectAdminTestPlan extends StatefulWidget {
  const ProjectAdminTestPlan({super.key});

  @override
  State<ProjectAdminTestPlan> createState() => _ProjectAdminTestPlanState();
}

class _ProjectAdminTestPlanState extends State<ProjectAdminTestPlan> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: Center(child: Text('TestPlan'),)),);
  }
}
