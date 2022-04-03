import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prijava_ispita/screens/admin/admin_settings_screen.dart';
import 'package:prijava_ispita/screens/exam_registration.dart';
import 'package:prijava_ispita/screens/registered_exams.dart';
import 'package:prijava_ispita/services/auth_service.dart';
import 'package:prijava_ispita/shared/constants.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    bool isAdmin = _auth.isCurrentUserAdmin();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Pocetna strana'),
        leading: appBarBanner,
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () async{
              await _auth.signOut(context);
            },
            icon: Icon(Icons.person, color: Colors.black,),
            label: Text('Odjava', style: TextStyle( color: Colors.black)),
          )
        ],
      ),
      floatingActionButton: isAdmin ?
      FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminSettingsScreen()
            )
          );
        },
      ) : null,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: isAdmin ?
          Text('Dobrodosli Admine!') :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Dobrodosli!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterExamsScreen()));
                  },
                  child: Text('Prijava ispita')
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteredExamsScreen()));
                  },
                  child: Text('Prijavljeni ispiti')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
