import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/services/api_service.dart';
import 'package:harbinger_flutter/services/project_service.dart';

// class ProjectScreenProjectAdmin extends StatelessWidget {
//   const ProjectScreenProjectAdmin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class ProjectScreenProjectAdmin extends StatelessWidget {
  const ProjectScreenProjectAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProjectCard(
          onTap: () {
            showProjectDetails(context);
          },
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final VoidCallback onTap;

  ProjectCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 200,
          height: 200,
          child: Center(
            child: Icon(
              Icons.add,
              size: 100,
            ),
          ),
        ),
      ),
    );
  }
}

void showProjectDetails(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return ProjectDetailsModal();
    },
  );
}

class ProjectDetailsModal extends StatefulWidget {
  @override
  _ProjectDetailsModalState createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<ProjectDetailsModal> {
  final ProjectService apiService = ProjectService();
  String? cdOption;
  String? selectedCdOption;

  TextEditingController projectNameController = TextEditingController();
  TextEditingController gitUrlController = TextEditingController();
  TextEditingController ciApiController = TextEditingController();
  TextEditingController ciUrlController = TextEditingController();
  TextEditingController workspaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Add Project',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Workspace Path:'),
              TextFormField(
                controller: workspaceController,
              ),
              SizedBox(height: 16),
              Text('Project Name:'),
              TextFormField(
                controller: projectNameController,
              ),
              SizedBox(height: 16),
              Text('Git URL:'),
              TextFormField(
                controller: gitUrlController,
              ),
              // ... Rest of the code for radio buttons, dropdown, and input fields

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final projectName = projectNameController.text;
                      final gitUrl = gitUrlController.text;
                      final ciUrl = ciUrlController.text;
                      final ciApiKey = ciApiController.text;
                      final cdRequired = cdOption;
                      final cdOptionSelected = selectedCdOption;
                      final workspacePath = workspaceController.text;

                      apiService.saveProjectDetails(
                        projectName: projectName,
                        gitUrl: gitUrl,
                        workspacePath: workspacePath,
                        cdRequired: cdRequired,
                        cdOptionSelected: cdOptionSelected,
                        ciUrl: ciUrl,
                        ciApiKey: ciApiKey,
                      );

                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
