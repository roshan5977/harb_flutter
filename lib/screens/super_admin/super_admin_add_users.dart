import 'package:flutter/material.dart';
import 'package:harbinger_flutter/models/user_model.dart';
import 'package:harbinger_flutter/services/api_service.dart';

class UserRegistrationForm extends StatefulWidget {
  final int orgId;
  final int roleRefId;

  const UserRegistrationForm({super.key, required this.orgId,required this.roleRefId});

  @override
  _UserRegistrationFormState createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  User user = User(
    firstName: '',
    lastName: '',
    emailId: '',
    password: '',
    createdOn: DateTime.now(),
    updatedOn: DateTime.now(),
    lastLoggedIn: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) => user.firstName = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => user.lastName = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => user.emailId = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add email validation here
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                onSaved: (value) => user.password = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
                          Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Add space at the top of the button
                child: ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      apiService.registerUser(widget.orgId, user,widget.roleRefId);
                    }
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
