import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prijava_ispita/models/course.dart';

class CourseRepository {

  void addCurse(Course course) async {
    List subjects = [];
    for (int i = 0; i < course.subjects!.length; i++) {
      subjects.add({
        "id": course.subjects![i].uid
      });
    }

    FirebaseFirestore.instance.collection('courses').add({
      'title': course.title,
      'subjects' : FieldValue.arrayUnion(subjects)
    }).then((value) {FirebaseFirestore.instance.collection('courses').doc(value.id).update({
      'id': value.id
    });
    });
  }

  Future<List<Course>> getAllCourses() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('courses')
        .get();
    List<Course> courses = [];
    qs.docs.forEach((element) {
      courses.add(Course.get(element.get('id'),
          element.get('title')));
    });
    return courses;
  }
}