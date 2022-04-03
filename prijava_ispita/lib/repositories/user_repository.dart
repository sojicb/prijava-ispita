import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prijava_ispita/models/user.dart';

class UserRepository{
  void deleteUser(String id) async{
    FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  void editUser(AppUser student) async{
    FirebaseFirestore.instance.collection('users').doc(student.uid).update({
      'index': student.index,
      'semester': student.semester,
      'course': student.courseId
    });
  }

  Future<List<AppUser>> getAllStudents() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('users').get();
    List<AppUser> students = [];
    qs.docs.forEach((element) {
      students.add(AppUser(element.get('uid'),
          element.get('index'),
          element.get('name'),
          element.get('lastName'),
          element.get('semester'),
          element.get('course'),
      ));
    });
    return students;
  }

  Future<AppUser> getStudentsById(String uid) async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('users')
        .where('uid', isEqualTo: uid)
        .get();
      return AppUser(qs.docs.single.get('uid'),
        qs.docs.single.get('index'),
        qs.docs.single.get('name'),
        qs.docs.single.get('lastName'),
        qs.docs.single.get('semester'),
        qs.docs.single.get('course'));
  }
}