import 'package:flutter/material.dart';
import 'package:prijava_ispita/shared/constants.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';

class EditSubjectScreen extends StatelessWidget {
  Subject subject;

  EditSubjectScreen({required this.subject});

  TextEditingController titleController = TextEditingController();
  TextEditingController professorController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = subject.title;
    professorController.text = subject.professor;
    pointsController.text = subject.points;
    semesterController.text = subject.semester;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: appBarBanner,
        title: const Text('Izmeni Predmet'),
        centerTitle: true,
        elevation: 0,
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
                    decoration: const InputDecoration(hintText: 'Naziv predmeta', labelText: 'Naziv predmeta', floatingLabelAlignment: FloatingLabelAlignment.center),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: professorController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Predmetni profesor', labelText: 'Predmetni profesor', floatingLabelAlignment: FloatingLabelAlignment.center),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: pointsController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'ESPB bodovi', labelText: 'ESPB bodovi', floatingLabelAlignment: FloatingLabelAlignment.center),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: semesterController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Semestar', labelText: 'Semestar', floatingLabelAlignment: FloatingLabelAlignment.center),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            SubjectRepository.post(context: context).editSubject(
                                Subject.get(subject.uid,
                                    titleController.text,
                                    professorController.text,
                                    pointsController.text,
                                    semesterController.text));
                            Navigator.pop(context);
                          },
                          child: const Text('Izmeni')),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ponisti')),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
