import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_management_with_firebase/Models/student_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_management_with_firebase/screens/success_page.dart';

class StudentDataScreen extends StatefulWidget {
  const StudentDataScreen({Key? key}) : super(key: key);

  @override
  State<StudentDataScreen> createState() => _StudentDataScreenState();
}

class _StudentDataScreenState extends State<StudentDataScreen> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _fathersName = TextEditingController();
  final TextEditingController _mothersName = TextEditingController();
  final TextEditingController _rollNumber = TextEditingController();
  final TextEditingController _classname = TextEditingController();
  final TextEditingController _classGroup = TextEditingController();
  final TextEditingController _studentContact = TextEditingController();
  final TextEditingController _homeContact = TextEditingController();

  String? _selectGender;
  String? _selectBloodGroup;
  String? _dateOfBirth;
  XFile? image;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> setImages() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    var snapshot = await FirebaseStorage.instance.ref("Student Image").child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(File(image!.path));
    _imageUrl = await snapshot.ref.getDownloadURL();
     setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff656867),
        body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          children: [

            const Center(
                child: Text(
              "Student Information",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 20,
            ),

            // Image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        border: Border.all(
                          color: Colors.white24,
                        ),
                        borderRadius: BorderRadius.circular(200),
                        image: image == null
                            ? const DecorationImage(
                                fit: BoxFit.fill, image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1JhsYBy43yMh9SZZ1ZFTyIAESbv-cGm64yqub3MQ&s"))
                            : DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(image!.path)),
                              )),
                  ),
                  Icon(Icons.camera_alt,color: Colors.black.withOpacity(.5),size: 40,).onTap((){setImages();})
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // Student Name
            AppTextField(
              controller: _name,
              textFieldType: TextFieldType.NAME,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your name here..",
                  prefixIcon: const Icon(Icons.account_circle),
                  labelText: "Student Name"),
            ),
            const SizedBox(
              height: 5,
            ),

            // fathers name
            AppTextField(
              controller: _fathersName,
              textFieldType: TextFieldType.NAME,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Father's name here..",
                  prefixIcon: const Icon(Icons.account_circle),
                  labelText: "Student Father's Name"),
            ),
            const SizedBox(
              height: 5,
            ),

            // Mother's name
            AppTextField(
              controller: _mothersName,
              textFieldType: TextFieldType.NAME,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Mother's name here..",
                  prefixIcon: const Icon(Icons.account_circle),
                  labelText: "Student Mother's Name"),
            ),
            const SizedBox(
              height: 5,
            ),

            // Roll Number
            AppTextField(
              controller: _rollNumber,
              textFieldType: TextFieldType.NUMBER,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Roll Number here..",
                  prefixIcon: const Icon(Icons.list_alt_outlined),
                  labelText: "Student Roll "),
            ),
            const SizedBox(
              height: 5,
            ),

            // Student Class,
            AppTextField(
              controller: _classname,
              textFieldType: TextFieldType.NAME,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Which Class do you read in?",
                  prefixIcon: const Icon(Icons.class_),
                  labelText: "Class Name"),
            ),
            const SizedBox(
              height: 5,
            ),

            // Class Group Name
            AppTextField(
              controller: _classGroup,
              textFieldType: TextFieldType.NAME,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Group",
                  prefixIcon: const Icon(Icons.group),
                  labelText: "Student Class Group"),
            ),
            const SizedBox(
              height: 5,
            ),

            // Date of Birth
            DateTimePicker(
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
              icon: const Icon(Icons.date_range),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.date_range),
                hintText: "Day : Month : Year",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
                )
              ),
              onChanged: (val){
                setState(() {
                  _dateOfBirth = val;
                });
              },
            ),
            const SizedBox(height: 5,),
            // Blood Group  & Gender
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton2(
                  underline: const Text(""),
                  buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(.3))),
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.teal,
                      border: Border.all(
                          color: Colors.black,
                          width: 4,
                          strokeAlign: StrokeAlign.inside)),
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.bloodtype,
                        color: Colors.grey,
                      ),
                      Text(
                        "Blood",
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectBloodGroup = value;
                    });
                  },
                  value: _selectBloodGroup,
                  items: const [
                    DropdownMenuItem(
                      value: "A+",
                      child: Text("A+"),
                    ),
                    DropdownMenuItem(
                      value: "A-",
                      child: Text("A-"),
                    ),
                    DropdownMenuItem(
                      value: "B+",
                      child: Text("B+"),
                    ),
                    DropdownMenuItem(
                      value: "B-",
                      child: Text("B-"),
                    ),
                    DropdownMenuItem(
                      value: "AB+",
                      child: Text("AB+"),
                    ),
                    DropdownMenuItem(
                      value: "AB-",
                      child: Text("AB-"),
                    ),
                    DropdownMenuItem(
                      value: "O+",
                      child: Text("O+"),
                    ),
                    DropdownMenuItem(
                      value: "O-",
                      child: Text("O-"),
                    ),
                  ],
                ),
                DropdownButton2(
                  underline: const Text(""),
                  buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black.withOpacity(.3))),
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.teal,
                      border: Border.all(
                          color: Colors.black,
                          width: 4,
                          strokeAlign: StrokeAlign.inside)),
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.menu_open_sharp,
                        color: Colors.grey,
                      ),
                      Text(
                        "Gender",
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectGender = value;
                    });
                  },
                  value: _selectGender,
                  items: const [
                    DropdownMenuItem(
                      value: "Male",
                      child: Text("Male"),
                    ),
                    DropdownMenuItem(
                      value: "Female",
                      child: Text("Female"),
                    ),
                    DropdownMenuItem(
                      value: "Custom",
                      child: Text("Custom"),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            // Student Contact
            AppTextField(
              controller: _studentContact,
              textFieldType: TextFieldType.PHONE,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Contact number",
                  prefixIcon: const Icon(Icons.call),
                  labelText: "Student Contact Number"),
            ),
            const SizedBox(
              height: 5,
            ),

            // Home Contact
            AppTextField(
              controller: _homeContact,
              textFieldType: TextFieldType.PHONE,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(.6)),
                  ),
                  hintText: "Enter your Home Contact",
                  prefixIcon: const Icon(Icons.call),
                  labelText: "Student Home Contact"),
            ),
            const SizedBox(
              height: 10,
            ),

            // submit Button
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  color: Colors.teal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Submit Data",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ).onTap(() async {
              StudentDataModel model = StudentDataModel(
                  studentName: _name.text,
                  fathersName: _fathersName.text,
                  mothersName: _mothersName.text,
                  dateOfBirth: _dateOfBirth,
                  rollNumber: _rollNumber.text,
                  className: _classname.text,
                  classGroup: _classGroup.text,
                  bloodGroup: _selectBloodGroup,
                  gender: _selectGender,
                  pictureUrl: _imageUrl,
                  studentContact: _studentContact.text,
                  familyContact: _homeContact.text);
              EasyLoading.show(status: "Updating Data");
                await FirebaseDatabase.instance
                  .ref("Student Info")
                  .push()
                  .set(model.toJson());
              await EasyLoading.showSuccess("Data Uploading Successful");
              SuccessPage().launch(context);
            })
          ],
        ),
      ),
    );
  }
}
