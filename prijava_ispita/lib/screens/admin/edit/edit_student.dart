import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/course.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/repositories/course_repository.dart';
import 'package:prijava_ispita/repositories/user_repository.dart';
import 'package:prijava_ispita/shared/constants.dart';

class EditStudentScreen extends StatefulWidget {
  AppUser student;

  EditStudentScreen({required this.student});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  Course _selectedDropDownValue = Course('uid', 'title', null);
  List<Course> dropDownItems = [];

  _EditStudentScreenState() {
    getCourses().then((val) =>
        setState(() {
          debugPrint(val.toString());
          dropDownItems = val;
          _selectedDropDownValue = val.first;
        }));
  }

  TextEditingController indexController = TextEditingController();
  TextEditingController orientationController = TextEditingController();
  TextEditingController semesterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: appBarBanner,
        title: const Text('Uredi Studenta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40,10,40,10),
        child: Container(
          child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(widget.student.name! + ' ' + widget.student.lastName!),
                  const SizedBox(height: 10),
                  TextField(
                    controller: indexController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Broj indexa'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: semesterController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: 'Semestar po redu'),
                  ),
                  const SizedBox(width: 20),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<Course>(

                      value: _selectedDropDownValue,
                      items: dropDownItems.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() {
                        _selectedDropDownValue = value!;
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            UserRepository().editUser(
                                AppUser.edit(widget.student.uid, indexController.text, semesterController.text, _selectedDropDownValue.uid));
                            Navigator.pop(context);
                          },
                          child: const Text('Dodaj')),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () { Navigator.pop(context) ;},
                          child: const Text('Ponisti'))
                    ],
                  ),

                ],
              )),
        ),
      ),
    );
  }

  Future<List<Course>> getCourses() async {
    return await CourseRepository().getAllCourses();
  }

  DropdownMenuItem<Course> buildMenuItem(Course item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.title,
        ),
      );
}


