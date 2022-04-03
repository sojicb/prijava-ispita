import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/repositories/user_repository.dart';
import 'package:prijava_ispita/screens/admin/edit/edit_student.dart';

class ListAllStudentsScreen extends StatefulWidget {

  @override
  _ListAllStudentsScreenState createState() => _ListAllStudentsScreenState();
}

class _ListAllStudentsScreenState extends State<ListAllStudentsScreen> {
  List<AppUser> allStudents = [];

  _ListAllStudentsScreenState() {
    getStudents().then((val) =>
        setState(() {
          allStudents = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Svi Studenti'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: allStudents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Card(
              child: ListTile(
                title: allStudents[index].index == null
                    ? Text(allStudents[index].name! + ' ' + allStudents[index].lastName!)
                    : Text(allStudents[index].index!),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.green,
                        onPressed: (){
                          debugPrint(allStudents[index].courseId.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditStudentScreen(student: allStudents[index])));
                        },
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: (){
                          UserRepository().deleteUser(allStudents[index].uid!);
                          getStudents().then((val) =>
                              setState(() {
                                allStudents = val;
                              }));
                        },
                      )]
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<AppUser>> getStudents() async {
    return await UserRepository().getAllStudents();
  }
}
