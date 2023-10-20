import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/workspace_model.dart';
import 'package:harbinger_flutter/services/api_service.dart';
import 'package:harbinger_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WorkspaceScreenProjectAdmin extends StatelessWidget {
  const WorkspaceScreenProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return  WorkspaceList(userId: 1);
  }
}


 
class WorkspaceList extends StatefulWidget {
  final int userId;
  final ApiService apiService = ApiService();
 
  WorkspaceList({required this.userId});
 
  @override
  _WorkspaceListState createState() => _WorkspaceListState();
}
 
class _WorkspaceListState extends State<WorkspaceList> {
  TextEditingController workspaceNameController = TextEditingController();
  TextEditingController workspacePathController = TextEditingController();
  TextEditingController workspacedevmacaddressController = TextEditingController();
  TextEditingController workspaceuser_ref_idController = TextEditingController();
  bool hasWorkspaces = false;
  List<Workspace> workspaces = [];
 
  void _showCreateWorkspaceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Workspace'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: workspaceNameController,
                decoration: InputDecoration(labelText: 'Workspace Name'),
              ),
              TextField(
                controller: workspacePathController,
                decoration: InputDecoration(labelText: 'Workspace Path'),
              ),
              TextField(
                controller: workspacedevmacaddressController,
                decoration: InputDecoration(labelText: 'devMACAddress'),
              ),
              TextField(
                controller: workspaceuser_ref_idController,
                decoration: InputDecoration(labelText: 'user_ref_id'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createWorkspace();
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
 
  void _createWorkspace() async {
    final workspace = Workspace(
      workspaceName: workspaceNameController.text,
      workspacePath: workspacePathController.text,
      devMacAddress: workspacedevmacaddressController.text,
      userRefId: int.parse(workspaceuser_ref_idController.text),
    );
 
    final newWorkspace = await widget.apiService.createWorkspace(workspace);
 print("outside++++++++++++++++++++++++++++++++++++++++");
      print(newWorkspace);
     
      setState(() {
        workspaces.add(newWorkspace);
        print(newWorkspace);
      });
 
  }
 
  @override
  void initState() {
    super.initState();
    _checkWorkspaces();
  }
 
  Future<void> _checkWorkspaces() async {
    final workspaceList = await widget.apiService.getWorkspaces(widget.userId);
    setState(() {
      workspaces = workspaceList;
      hasWorkspaces = workspaceList.isNotEmpty;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          if(hasWorkspaces)
            ElevatedButton(
              onPressed: () {
                _showCreateWorkspaceDialog();
              },
              child: Text('Add'),
            ),
            if(!hasWorkspaces)
            Padding(
              padding: const EdgeInsets.all(200.0),
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Text('No Workspace Available'),
                      SizedBox(height: 20,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: SpecialColors.Blue2),

                        onPressed: () {
                          _showCreateWorkspaceDialog();
                        },
                        child: Text('Create Workspace'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: workspaces.length,
              itemBuilder: (context, index) {
                final workspace = workspaces[index];
       
                return Card(
                  color: workspace.isOrphan ? Colors.grey : Colors.white,
                  child: ListTile(
                    title: Text(workspace.workspaceName),
                    subtitle: Text(workspace.workspacePath),
                    onTap: () {
                      if (!workspace.isOrphan) {
                       
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}