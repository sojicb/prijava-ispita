import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/course.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';

class RegisteredExamsScreen extends StatefulWidget {
  const RegisteredExamsScreen({Key? key}) : super(key: key);

  @override
  _RegisteredExamsScreenState createState() => _RegisteredExamsScreenState();
}

class _RegisteredExamsScreenState extends State<RegisteredExamsScreen> {
  Future<List<Subject>> _myData = SubjectRepository.get().getAllRegisteredSubjects();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Prijavljeni Ispiti'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: _myData,
          builder: (context, AsyncSnapshot<List<Subject>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }else if(snapshot.connectionState == ConnectionState.done){
              List<Subject> subjects = snapshot.data!;
              List<String> subjectIds = [];
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  subjectIds.add(snapshot.data![index].uid!);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Card(
                      child: ListTile(
                        onTap: (){
                          subjectIds.remove(snapshot.data![index].uid);
                          showAlertDialog(context, subjectIds, snapshot.data![index].uid!);
                        },
                        title: Text(snapshot.data![index].title),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('Greska');
            }
          }
      ),
    );
  }

  Widget showAlertDialog(BuildContext context, List<String> subjectIds, String examToRemove) {
    Widget cancelButton = TextButton(
      child: Text("Otkazi"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Nastavi"),
      onPressed:  () {
        SubjectRepository.post(context: context).updateExamForUser(subjectIds, examToRemove);
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Future.delayed(Duration(seconds: 2), (){
          setState(() {
            _myData = SubjectRepository.get().getAllRegisteredSubjects();
          });
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Uspesno odjavljen ispit')));
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text("Da li zelite da odjavite ispit?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return alert;
  }
}
