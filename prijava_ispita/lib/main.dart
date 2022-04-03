import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/screens/authenticate/sign_in.dart';
import 'package:prijava_ispita/screens/home.dart';
import 'package:prijava_ispita/services/auth_service.dart';
import 'package:provider/provider.dart';
import '';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prijava Ispita',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue
      ),
      home: FirebaseAuth.instance.currentUser != null ?
      Home() : const SignIn(),
    );
  }
}
