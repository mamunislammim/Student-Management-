import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_management_with_firebase/screens/sign_in_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email =TextEditingController();
  final TextEditingController _password = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
        children: [
          AppTextField(
            controller: _email,
            textFieldType: TextFieldType.EMAIL,
            decoration:   InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                ),
                hintText: "email@gmail.com",
                labelText: "Enter Email Address"
            ),
          ),
          const SizedBox(height: 8,),
          AppTextField(
            controller: _password,
            textFieldType: TextFieldType.PASSWORD,
            decoration:   InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black.withOpacity(.4)),
                ),
                hintText: "********",
                labelText: "Enter Password"
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.only(top: 12,bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.teal,
            ),
            child: const Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
          ).onTap(()async {
            try {
              EasyLoading.show(status: "Wait");
              final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _email.text,
                password: _password.text,
              );
              EasyLoading.showSuccess("Ok");
              SignInScreen().launch(context);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                EasyLoading.showError("The password provided is too weak");
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                EasyLoading.showError("The account already exists for that email");
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          })
        ],
      ),
    );
  }
}
