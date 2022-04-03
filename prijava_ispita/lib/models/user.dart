import 'package:prijava_ispita/models/subject.dart';

class AppUser{

  final String? uid;
  String? name;
  String? lastName;
  final String? index;
  final String? semester;
  String? courseId;
  List<Subject>? exams;

  AppUser(this.uid, this.index, this.name, this.lastName, this.semester, this.courseId);
  AppUser.edit(this.uid, this.index, this.semester, this.courseId);
}