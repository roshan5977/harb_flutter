import 'package:flutter/material.dart';

class ProjectAdminReportScreen extends StatefulWidget {
  const ProjectAdminReportScreen({super.key});

  @override
  State<ProjectAdminReportScreen> createState() => _ProjectAdminReportScreenState();
}

class _ProjectAdminReportScreenState extends State<ProjectAdminReportScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: Center(child: Text('ReportScreen'),)),);
  }
}