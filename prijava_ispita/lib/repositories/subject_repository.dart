import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:prijava_ispita/models/exam.dart';
import 'package:prijava_ispita/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:prijava_ispita/models/user.dart';
import 'package:prijava_ispita/repositories/exam_repository.dart';
import 'package:prijava_ispita/repositories/user_repository.dart';

class SubjectRepository {
  BuildContext? context;

  SubjectRepository.post({required this.context});
  SubjectRepository.get();

  void addSubject(Subject subject) async {
    FirebaseFirestore.instance.collection('subjects').add({
      'title': subject.title,
      'professor': subject.professor,
      'points': subject.points,
      'semester': subject.semester
    }).then((value) {
      FirebaseFirestore.instance.collection('subjects').doc(value.id).update({
        'uid': value.id
      });
    });
  }

  void deleteSubject(String id) async {
    FirebaseFirestore.instance.collection('subjects').doc(id).delete();
  }

  void editSubject(Subject subject) async {
    FirebaseFirestore.instance.collection('subjects').doc(subject.uid).update({
      'title': subject.title,
      'professor': subject.professor,
      'points': subject.points,
      'semester': subject.semester
    });
  }

  void registerExamForUser(String id) async {
    List registeredExams = [];
    registeredExams.add({
        "id": id
      });

    try{
      await FirebaseFirestore.instance.collection("users").
      doc(FirebaseAuth.instance.currentUser!.uid).update({
        'exams': FieldValue.arrayUnion(registeredExams)
      });
      ExamRepository().addExam(Exam(FirebaseAuth.instance.currentUser!.uid, id, null, null, null));
    } catch(e){
      debugPrint(e.toString());
    }
  }

  void updateExamForUser(List<String> subjects, String examToRemove) async {
    AppUser student = await UserRepository().getStudentsById(FirebaseAuth.instance.currentUser!.uid);
    List registeredExams = [];
    for(var subject in subjects){
      registeredExams.add({
        "id": subject
      });}

    await FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser!.uid).set({
      'course': student.courseId,
      'index': student.index,
      'lastName': student.lastName,
      'name': student.name,
      'semester': student.semester,
      'uid': student.uid,
      'exams': FieldValue.arrayUnion(registeredExams)
    });

    ExamRepository().deleteExam(examToRemove);
  }

  Future<List<Subject>> getCourseForStudent() async {
    try{
      List<Subject> allSubjects = [];
      List<Subject> registeredSubjects = [];
      List<Subject> returnSubjects = [];

      await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get().then((value) async {

        registeredSubjects = await getAllRegisteredSubjects();
        allSubjects.addAll(await _getCourseById(value.docs.single.get('course')));
        returnSubjects.addAll(await _getCourseById(value.docs.single.get('course')));

        for(var subject in allSubjects){
          for(var reg in registeredSubjects){
            if(reg.uid == subject.uid) {
              returnSubjects.removeWhere((Subject item) => item.uid == reg.uid);
            } else {
              continue;
            }
          }
        }
      });
      return returnSubjects;
    } catch(e){
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Subject>> _getCourseById(String uid) async {
    try{
      List<Subject> subjects = [];
      await FirebaseFirestore.instance.collection('courses')
          .where('id', isEqualTo: uid).get().then((value) async {
        subjects.addAll(await _getSubjectsForGivenListOfIds(value.docs.single.get('subjects')));
        return subjects;
      });
      return subjects;
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Subject>> _getSubjectsForGivenListOfIds(List<dynamic> ids) async {
    try {
      List<Subject> subjects = [];
      List<dynamic> subjectIds = ids.map((e){
        return e['id'];
      }).toList();
      await FirebaseFirestore.instance.collection('subjects')
          .where('uid', whereIn: subjectIds)
          .get().then((value) {
        for (var element in value.docs) {
            subjects.add(Subject.get(
                element.get('uid'),
                element.get('title'),
                element.get('professor'),
                element.get('points'),
                element.get('semester')));
        }
        return [];
      });
      return subjects;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Subject>> getAllRegisteredSubjects() async {
    try{
      List<Subject> subjects = [];
      await FirebaseFirestore.instance.collection('users')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
        subjects.addAll(await _getSubjectsForGivenListOfIds(value.docs.single.get('exams')));
      });
      return subjects;
    }catch(e){
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Subject>> getAllSubjects() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('subjects')
        .get();
    List<Subject> subjects = [];
    qs.docs.forEach((element) {
      subjects.add(Subject.create(element.get('uid'),
          element.get('title'),
          element.get('professor'),
          element.get('points'),
          element.get('semester')));
    });
    return subjects;
  }

  Future<List<Subject>> getAllSubjectsBySemester(String semester) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('subjects')
        .where('semester', isEqualTo: semester)
        .get();
    List<Subject> subjects = [];
    qs.docs.forEach((element) {
      subjects.add(Subject.create(element.get('uid'),
          element.get('title'),
          element.get('professor'),
          element.get('points'),
          element.get('semester')));
    });
    return subjects;
  }
}