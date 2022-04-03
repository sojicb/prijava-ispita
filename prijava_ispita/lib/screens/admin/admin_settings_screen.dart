import 'package:flutter/material.dart';
import 'package:prijava_ispita/screens/admin/add/add_orientation.dart';
import 'package:prijava_ispita/screens/admin/add/add_subject.dart';
import 'package:prijava_ispita/screens/admin/list_all/list_students.dart';
import 'package:prijava_ispita/screens/admin/list_all/list_subjects.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Admin panel'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddSubjectScreen())
                    );
                  },
                  child: const Text('Dodajte novi predmet')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ListAllSubjectScreen())
                    );
                  },
                  child: const Text('Predmeti')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ListAllStudentsScreen())
                    );
                  },
                  child: const Text('Studenti')
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddOrientationScreen())
                    );
                  },
                  child: const Text('Dodaj Smer')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
