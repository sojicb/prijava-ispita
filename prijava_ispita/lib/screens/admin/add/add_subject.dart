import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';
import 'package:prijava_ispita/shared/constants.dart';

class AddSubjectScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController professorController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SubjectRepository _subjectRepository = SubjectRepository.post(context: context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: appBarBanner,
        title: Text('Dodaj novi predmet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40,10,40,10),
        child: Container(
          child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    controller: titleController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: 'Naziv predmeta'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: professorController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: 'Ime i prezime predmetnog profesora'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: pointsController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: 'Broj ESPB bodova'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: semesterController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: 'Semestar po redu'),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _subjectRepository.addSubject(
                                  Subject(titleController.text,
                                      professorController.text,
                                      pointsController.text,
                                      semesterController.text));
                              Navigator.pop(context);
                            },
                            child: Text('Dodaj')),
                        const SizedBox(width: 30),
                        ElevatedButton(
                            onPressed: () { Navigator.pop(context) ;},
                            child: Text('Ponisti'))
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
