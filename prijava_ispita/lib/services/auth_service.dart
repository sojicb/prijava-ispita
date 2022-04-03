import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/screens/authenticate/sign_in.dart';
import 'package:prijava_ispita/screens/home.dart';
import 'package:flutter/material.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // AppUser? _authFirebaseUser(User? user){
  //   return user != null ? AppUser(user.uid, null, null, null, 0, null) : null;
  // }
  //
  // Stream<AppUser?> get user {
  //   return _auth.authStateChanges().map(_authFirebaseUser);
  // }

  bool isCurrentUserAdmin() {
    return _auth.currentUser!.uid == 'iCsaD7uI7hVBizJp3u45Ypa02xF3';
  }

  //register with email and password
  Future register(String email, String password, AppUser userToRegister) async {
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return addUser(AppUser(user!.uid, null, userToRegister.name, userToRegister.lastName, '1', null));
    } catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  //sign in
  Future signIn(String email, String password, context) async {
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home()));
    } catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
 Future signOut(context) async{
    try{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignIn()));
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
 }

 void addUser(AppUser user) async{
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': user.name,
      'lastName': user.lastName,
      'index': user.index,
      'semester': user.semester,
      'uid': user.uid,
      'course': null,
      'exams': []
    });
 }
}