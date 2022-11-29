import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:student_management_with_firebase/screens/sign_in_page.dart';
import 'package:student_management_with_firebase/screens/sign_up_screen.dart';
import 'package:student_management_with_firebase/screens/student_data_screen.dart';
import 'firebase_option.dart';

void main()async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
      builder: EasyLoading.init(),
    );
  }
}