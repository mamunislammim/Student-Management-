import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_management_with_firebase/Models/student_model.dart';
import 'package:student_management_with_firebase/provider/studentData.dart';
import 'package:student_management_with_firebase/screens/set_student_info_screen.dart';
import 'package:student_management_with_firebase/screens/student_profile.dart';

class StudentInfoList extends StatefulWidget {
  const StudentInfoList({Key? key}) : super(key: key);

  @override
  State<StudentInfoList> createState() => _StudentInfoListState();
}

class _StudentInfoListState extends State<StudentInfoList> {
  int _deleteIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          const CircleAvatar(child: Icon(Icons.add)).onTap(() {
        const SetStudentInfoScreen().launch(context);
      }),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back).onTap(() {
          StudentInfoList().launch(context);
        }),
        title: const Text("All Student Info"),
        centerTitle: true,
      ),
      body: Consumer(builder: (_, ref, watch) {
        AsyncValue<List<StudentDataModel>> studentInfo =
            ref.watch(studentProvider);
        return studentInfo.when(data: (data) {
          return RefreshIndicator(
            onRefresh: () async => await ref.refresh(studentProvider),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onLongPress: () {
                      setState(() {
                        _deleteIcon = 1;
                      });
                    },
                    onTap: () {
                      setState(() {
                        _deleteIcon = 0;
                        print(data[index].pictureUrl);
                      });
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(data[index].pictureUrl.toString()),
                    ),
                    title: Text(data[index].studentName.toString()),
                    subtitle:
                        Text("Roll : ${data[index].rollNumber.toString()}"),
                    trailing: _deleteIcon == 0
                        ? const Icon((Icons.arrow_forward_ios_sharp)).onTap(() {
                            StudentProfileScreen(
                              studentID: index,
                            ).launch(context);
                          })
                        : const Icon(Icons.delete).onTap(() async {
                            EasyLoading.show(status: "Delete");
                            await FirebaseDatabase.instance
                                .ref("Student Info")
                                .child("")
                                .remove();
                            EasyLoading.showSuccess("Ok");
                          }),
                  );
                }),
          );
        }, error: (e, stack) {
          return Text(e.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
      }),
    );
  }
}