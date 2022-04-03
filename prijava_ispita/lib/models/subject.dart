class Subject{
  Subject(this.title, this.professor, this.points, this.semester);
  Subject.create(this.uid, this.title, this.professor, this.points, this.semester);
  Subject.get(this.uid, this.title, this.professor, this.points, this.semester);

  String? uid;
  final String title;
  final String professor;
  final String points;
  final String semester;
}