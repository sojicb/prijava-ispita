import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prijava_ispita/models/exam.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ExamRepository{
  void deleteExam(String id) async{
    await FirebaseFirestore.instance.collection('registeredExams')
        .where('subjectId', isEqualTo: id)
        .where('studentUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
      FirebaseFirestore.instance.collection('registeredExams').doc(value.docs.first.get('uid')).delete();
    });
  }

  void addExam(Exam exam) async{
    FirebaseFirestore.instance.collection('registeredExams').add({
      'studentUid': exam.studentUid,
      'subjectId': exam.subjectId,
      'examDate': exam.examDate,
      'grade': exam.grade,
      'points': exam.points
    }).then((value) {
      FirebaseFirestore.instance.collection('registeredExams').doc(value.id).update({
        'uid': value.id
      });
    });
  }
}