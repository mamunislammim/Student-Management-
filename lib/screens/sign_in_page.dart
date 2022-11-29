import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_management_with_firebase/screens/sign_up_screen.dart';
import 'package:student_management_with_firebase/screens/student_data_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 200,left: 20,right: 20),
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
              child: const Center(child: Text("Sign In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),)),
            ).onTap(()async{
              try{
                EasyLoading.show(status: "Signing In");
                   await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email.text,
                    password: _password.text,
                );
                EasyLoading.showSuccess("Sign In Successful");
                if(FirebaseAuth.instance.currentUser!.uid.isNotEmpty){
                   StudentDataScreen().launch(context);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  EasyLoading.showError("user-not-found");
                } else if (e.code == 'wrong-password') {
                  EasyLoading.showError("wrong-password");
                }
              }
            }),
            const SizedBox(height: 10,),
            Row(
              children:   [
                const Text(" Don't have any Account?",),
                const SizedBox(width: 5,),
                const Text("Sign Up",style: TextStyle(color: Colors.blue,fontSize: 16),).onTap((){SignUpScreen().launch(context);})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
