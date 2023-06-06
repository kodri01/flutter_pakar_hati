import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pakar_hati/pages/navbar.dart';
import 'package:pakar_hati/pages/welcome.dart';
import 'package:pakar_hati/providers/helper_funtion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedStatus();
  }

  getUserLoggedStatus() async {
    await HelperFuntions.getUserLoggedStatus().then((value) => {
          if (value != null) {_isSignedIn = value}
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const NavBar() : const Welcome(),
    );
  }
}



// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data != null) {
//           // UserHelper.saveUser(snapshot.data);
//           return StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(snapshot.data!.uid)
//                 .snapshots(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot<dynamic>> snapshot) {
//               if (snapshot.hasData && snapshot.data != null) {
//                 final user = snapshot.data!.data();
//                 if (user['role'] == 'admin') {
//                   return const AdminNavBar();
//                 } else {
//                   return const NavBar();
//                 }
//               }
//               return Material(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             },
//           );
//         }
//         return Welcome();
//       },
//     );
//   }
// }
