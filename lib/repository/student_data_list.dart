


import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:student_management_with_firebase/Models/student_model.dart';

class Repo{

  Future<List<StudentDataModel>> getAllStudentDataRepo()async{
    List<StudentDataModel> studentList = [];
    await FirebaseDatabase.instance.ref("Student Info").orderByKey().get().then((value) => {
      for(var element in value.children){
        studentList.add(StudentDataModel.fromJson(jsonDecode(jsonEncode(element.value))))
      }
    });
    return studentList;
  }
}