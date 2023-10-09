import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/organaisation_model.dart';
import 'package:harbinger_flutter/screens/edit_organisation_screen.dart';
import 'package:harbinger_flutter/services/organisation_service.dart';

class OrganisationScreen extends StatefulWidget {
  @override
  _OrganisationScreenState createState() => _OrganisationScreenState();
}
class _OrganisationScreenState extends State<OrganisationScreen> {
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getAllOrganisations(),
        builder: (BuildContext context, AsyncSnapshot<List<Organisation>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Organisation>? organisations = snapshot.data;
            return _buildListView(organisations!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Organisation> organisations) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Organisation organisation = organisations[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      organisation.orgName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, 
                      ),
                    ),
                    Text(organisation.orgCode),
                    Text(organisation.orgDesc),
                    Text(organisation.orgStartDate.toString()),
                    Text(organisation.orgEndDate.toString()),
                    Text(organisation.status),
                    Text(organisation.createdBy),
                    Text(organisation.updatedBy),
                    Text(organisation.createdOn.toString()),
                    Text(organisation.updatedOn.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            // TODO: Implement delete action
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditOrganisationScreen(
                                  organisation: organisation,
                                  onSave: (updatedOrganisation) {
                                  
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: organisations.length,
      ),
    );
  }
}
