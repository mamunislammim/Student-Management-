import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
 import 'package:student_management_with_firebase/Models/student_model.dart';
import 'package:student_management_with_firebase/provider/studentData.dart';
import 'package:student_management_with_firebase/screens/edit_student_info.dart';
 
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key, required this.studentID})
      : super(key: key);
  final int? studentID;

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, watch) {
      AsyncValue<List<StudentDataModel>> studentData =
          ref.watch(studentProvider);
      return studentData.when(data: (data) {
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text("Student Profile"),
          //   centerTitle: true,
          //   actions: [
          //     const CircleAvatar(
          //         child: Icon(
          //       Icons.edit,
          //       size: 30,
          //     )).onTap(() {
          //          EditStudentInfo(studentData: data[0],).launch(context);
          //     }),
          //     const SizedBox(
          //       width: 10,
          //     )
          //   ],
          // ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:   [
                      Container(
                        padding: const EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),color: Colors.blue
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.edit,size: 30,color: Colors.white,),
                            Text("Edit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)
                          ],
                        ),
                      ).onTap((){
                        EditStudentInfo(data[widget.studentID?.toInt()?? 0],).launch(context);
                      }),
                      const SizedBox(width: 10,)
                    ],
                  ),
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(
                        data[widget.studentID?.toInt() ?? 0]
                            .pictureUrl
                            .toString()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    data[widget.studentID?.toInt() ?? 0].studentName.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Father's Name :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Mother's Name :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Date of Birth :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Gender :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Semester :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Class Group :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Blood Group :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Class Roll :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Student Contact : ",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "Home Contact :",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .fathersName
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .mothersName
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .dateOfBirth
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .gender
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .className
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .classGroup
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .bloodGroup
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[0].rollNumber.toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .studentContact
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              data[widget.studentID?.toInt() ?? 0]
                                  .familyContact
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, error: (e, stack) {
        return Center(
          child: Text(e.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    });
  }
}
