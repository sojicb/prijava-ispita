import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/course.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';

class RegisterExamsScreen extends StatefulWidget {
  const RegisterExamsScreen({Key? key}) : super(key: key);

  @override
  _RegisterExamsScreenState createState() => _RegisterExamsScreenState();
}

class _RegisterExamsScreenState extends State<RegisterExamsScreen> {
  Future<List<Subject>> _myData = SubjectRepository.get().getCourseForStudent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Ispiti'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _myData,
        builder: (context, AsyncSnapshot<List<Subject>> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.connectionState == ConnectionState.done){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  child: Card(
                    child: ListTile(
                      onTap: (){
                        showAlertDialog(context, snapshot.data![index].uid!);
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


  Widget showAlertDialog(BuildContext context, String uid) {
    Widget cancelButton = TextButton(
      child: Text("Otkazi"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget continueButton = TextButton(
      child: Text("Nastavi"),
      onPressed:  () {
        SubjectRepository.post(context: context).registerExamForUser(uid);
        Navigator.of(context, rootNavigator: true).pop('dialog');
        setState(() {
          _myData = SubjectRepository.get().getCourseForStudent();
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Uspesno prijavljen ispit')));
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text("Da li zelite da prijavite ispit?"),
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
