import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/course.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/course_repository.dart';
import 'package:prijava_ispita/screens/admin/list_all/select_subjects.dart';
import 'package:prijava_ispita/shared/constants.dart';

class AddOrientationScreen extends StatefulWidget {
  @override
  State<AddOrientationScreen> createState() => _AddOrientationScreenState();
}

class _AddOrientationScreenState extends State<AddOrientationScreen> {
  TextEditingController titleController = TextEditingController();
  List<Subject> subjects = [];

  @override
  Widget build(BuildContext context) {
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
                    decoration: const InputDecoration(hintText: 'Naziv Smera'),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: buildMultipleSubjects(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              CourseRepository()
                                  .addCurse(Course.create(titleController.text, subjects));
                              Navigator.pop(context);
                            },
                            child: const Text('Dodaj')),
                        const SizedBox(width: 30),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ponisti'))
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

    Widget buildMultipleSubjects(){
      final subjectsText = subjects.map((subject) => subject.title).join(', ');
      final onTap = () async {
        final subjects = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SelectSubjectScreen(isMultiSelection: true))
        );
        if(subjects == null) return;

        setState(() {
          this.subjects = subjects;
        });
      };

      return subjects.isEmpty
         ? buildListTile(title: 'Nema izabranih predmeta', onTap: onTap)
         : buildListTile(title: subjectsText, onTap: onTap);
    }

    Widget buildListTile({
      @required String? title,
      @required VoidCallback? onTap
    }){
    return ListTile(
      onTap: onTap,
      title: Text(
        title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.black),
      );
    }
}


