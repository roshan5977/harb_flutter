import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  void _orgAdmin() {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Organisation Admin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Retrieve the entered values
              String firstName = firstNameController.text;
              String lastName = lastNameController.text;
              String email = emailController.text;
              String password = passwordController.text;

              // Do something with the captured data, e.g., save it
              print('First Name: $firstName');
              print('Last Name: $lastName');
              print('Email: $email');
              print('Password: $password');

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Register'),
          ),
        ],
      );
    },
  );
}

 void _projectAdmin() {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Project Admin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Retrieve the entered values
              String firstName = firstNameController.text;
              String lastName = lastNameController.text;
              String email = emailController.text;
              String password = passwordController.text;

              // Do something with the captured data, e.g., save it
              print('First Name: $firstName');
              print('Last Name: $lastName');
              print('Email: $email');
              print('Password: $password');

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Register'),
          ),
        ],
      );
    },
  );
}


  void _projectMembers() {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Project Members'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Retrieve the entered values
              String firstName = firstNameController.text;
              String lastName = lastNameController.text;
              String email = emailController.text;
              String password = passwordController.text;

              // Do something with the captured data, e.g., save it
              print('First Name: $firstName');
              print('Last Name: $lastName');
              print('Email: $email');
              print('Password: $password');

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text('Register'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _orgAdmin,
              child: Text('Add Organisation Admin'),
            ),
            ElevatedButton(
              onPressed: _projectAdmin,
              child: Text('Add Project Admin'),
            ),
            ElevatedButton(
              onPressed: _projectMembers,
              child: Text('Add Project members'),
            ),
          ],
        ),
      ),
    );
  }
}
