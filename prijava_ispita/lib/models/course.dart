import 'package:prijava_ispita/models/subject.dart';

class Course{
  Course(this.uid, this.title, this.subjects);
  Course.get(this.uid, this.title);
  Course.create(this.title, this.subjects);

  String? uid;
  final String title;
  List<Subject>? subjects;
}