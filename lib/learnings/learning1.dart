// import 'package:flutter/material.dart';

// Provider(
//   create:(_)=>user()
//   child:MyApp();
// )

// class MyApp extends StatelessWidget{

//   @override
//    Widget build(BuildContext context){
//     return MaterialApp(
//       routes:<String,WidgetBuilder>{
//         '/':(context)=> Home();
//         '/settings':(context)=>Settings();
//       },
//     );

//   }
// }


// // class Home extends StatefulWidget {
// //   const Home({super.key});

// //   @override
// //   State<Home> createState() => _HomeState();
// // }

// // class _HomeState extends State<Home> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }

// class Home extends StatefulWidget{
//   const Home({super.key});

//   @override
//   State<Home> createState() =>_HomeState();
// }

//   class _HomeState extends State<Home>{
//     @override
//     Widget build (BuildContext context){
//       final user =Provider.of<User>(context);
//       return MaterialApp();
//     }
//   }



// you can use Flutter's Provider package for state management. 
// Provider can be used to share and manage application state across your Flutter app.
// provider is just getting desired things from context river 
// data flow from up to down context not viceversa

// we can use multiprovider for good code readability for mulitiple providers.

//proxy provider will update its child widget whenever the data that is passing changes.proxyprovider0

