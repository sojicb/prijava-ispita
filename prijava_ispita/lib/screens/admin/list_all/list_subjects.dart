import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';
import 'package:prijava_ispita/screens/admin/edit/edit_subject.dart';

class ListAllSubjectScreen extends StatefulWidget {

  @override
  State<ListAllSubjectScreen> createState() => _ListAllSubjectScreenState();
}

class _ListAllSubjectScreenState extends State<ListAllSubjectScreen> {
  String? dropdownValue = '';
  final dropDownItems = ['', '1', '2', '3', '4', '5', '6', '7', '8'];
  List<Subject> allSubjects = [];

  _ListAllSubjectScreenState() {
    getSubjects().then((val) =>
        setState(() {
          allSubjects = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Svi Predmeti'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Filter po semestru'),
                const SizedBox(width: 20),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownValue,
                    items: dropDownItems.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                      dropdownValue = value as String;
                      if(value == ''){
                        getSubjects().then((val) =>
                            setState(() {
                              allSubjects = val;
                            }));
                      } else {
                        getSubjectsBySemester(value).then((val) =>
                            setState(() {
                              allSubjects = val;
                            }));
                      }
                    }),
                  ),
                ),
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allSubjects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  child: Card(
                    child: ListTile(
                      leading: Text(allSubjects[index].semester),
                      title: Text(allSubjects[index].title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.green,
                            onPressed: () async{
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      EditSubjectScreen(subject: allSubjects[index])));
                              dropdownValue = '';
                              getSubjects().then((val) =>
                                  setState(() {
                                    allSubjects = val;
                                  }));
                            },
                          ),
                          const SizedBox(width: 15),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: (){
                              SubjectRepository.get().deleteSubject(allSubjects[index].uid!);
                              getSubjects().then((val) =>
                                  setState(() {
                                    allSubjects = val;
                                  }));
                            },
                          )]
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
    DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );

  
  Future<List<Subject>> getSubjects() async {
    return await SubjectRepository.get().getAllSubjects();
  }

  Future<List<Subject>> getSubjectsBySemester(String semester) async {
    return await SubjectRepository.get().getAllSubjectsBySemester(semester);
  }
}
