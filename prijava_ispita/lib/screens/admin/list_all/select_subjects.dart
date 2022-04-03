import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:prijava_ispita/repositories/subject_repository.dart';
import 'package:prijava_ispita/screens/admin/widgets/subject_list_tile_widget.dart';
import 'package:prijava_ispita/screens/admin/widgets/search_widget.dart';

class SelectSubjectScreen extends StatefulWidget {
  final bool isMultiSelection;

  const SelectSubjectScreen({
    Key? key,
    this.isMultiSelection = false
  }) : super(key: key);

  @override
  _SelectSubjectScreenState createState() => _SelectSubjectScreenState();
}

class _SelectSubjectScreenState extends State<SelectSubjectScreen> {
  String text = '';
  List<Subject> selectedSubjects = [];
  List<Subject> allSubjects = [];
  List<Subject> searchSubjects = [];

  bool containsSearchText(Subject subject){
    final name = subject.title;
    final textLower = text.toLowerCase();
    final subjectLower = name.toLowerCase();

    return subjectLower.contains(textLower);
  }

  _SelectSubjectScreenState() {
    getSubjects().then((val) =>
        setState(() {
          allSubjects = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    searchSubjects = allSubjects.where(containsSearchText).toList();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Izaberite predmet'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SearchWidget(
            text: text,
            hintText: 'Pretrazi predmete',
            onChanged: (text) => setState(() {
              this.text = text;
            }),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: searchSubjects.map((subject) {
                final isSelected = selectedSubjects.contains(subject);
                return SubjectListTileWidget(
                  subject: subject,
                  isSelected: isSelected,
                  onSelectedSubject: selectSubject,
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  Widget buildSelectButton(BuildContext context){
    final label = widget.isMultiSelection ?
        'Dodaj ${selectedSubjects.length} predmeta' :
        'Dodaj';

    return Container(
      color: Theme.of(context).primaryColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(40)
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        onPressed: () {
          Navigator.pop(context, selectedSubjects);
        },
    ),
    );
  }

  void selectSubject(Subject subject){
    if(widget.isMultiSelection){
      final isSelected = selectedSubjects.contains(subject);
      setState(() {
        isSelected ? selectedSubjects.remove(subject) :
        selectedSubjects.add(subject);
      });
    } else {
      Navigator.pop(context, subject);
    }
  }

  Future<List<Subject>> getSubjects() async {
    return await SubjectRepository.get().getAllSubjects();
  }
}
