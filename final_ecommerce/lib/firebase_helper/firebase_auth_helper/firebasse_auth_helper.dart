

import 'package:final_ecommerce/constants/contants.dart';
import 'package:final_ecommerce/constants/routes.dart';
//import 'package:final_ecommerce/screens/auth_ui/sign_up/sign_up.dart';
import 'package:final_ecommerce/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class FirebaseAuthHelper {
 static FirebaseAuthHelper instance =  FirebaseAuthHelper();
 final FirebaseAuth _auth=FirebaseAuth.instance;
 Stream<User?> get getAuthChange=>_auth.authStateChanges();


 Future<bool> login(String email, String password, BuildContext context) async{
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Routes.instance.pushAndRemoveUntil(widget: Home(), context: context);
      Navigator.of(context).pop();
      return true;
    }on FirebaseAuthException catch(error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
 }

  Future<bool> signUp(String email, String password, BuildContext context) async{
    try {
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Routes.instance.pushAndRemoveUntil(widget: Home(), context: context);
      Navigator.of(context).pop();
      return true;
    }on FirebaseAuthException catch(error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
 }
}