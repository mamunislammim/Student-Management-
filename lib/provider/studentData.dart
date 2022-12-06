
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_with_firebase/Models/student_model.dart';
import 'package:student_management_with_firebase/repository/student_data_list.dart';

final studentProvider = FutureProvider<List<StudentDataModel>>((ref) => Repo().getAllStudentDataRepo());
