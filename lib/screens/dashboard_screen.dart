// import 'package:flutter/material.dart';
// import 'package:harbinger_flutter/screens/super_admin/super_admin_createorg.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: OrganizationScreen(),
//     );
//   }
// }

// class OrganizationScreen extends StatelessWidget {
//   const OrganizationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Organizations'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'No organizations are available',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CreateOrganisation(),
//       ),
//     );
//               },
//               child: const Text('Create Organization'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // oe