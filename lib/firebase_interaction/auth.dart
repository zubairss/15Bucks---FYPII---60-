import 'package:fifteenbucks/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/home_screen.dart';
import 'package:fifteenbucks/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import 'firestore/fire_store_auth.dart';


class AuthOperations {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp(BuildContext context, String email, String password,
      String fullName) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User? user = _auth.currentUser;
        FireStoreAuthData().storeSignUpData(fullName);
        if (user != null && !user.emailVerified) {
          showSnackBarFailed(context, 'Please verify your email first.');

          await user.sendEmailVerification();
          screenPushRep(context, const LoginScreen());
          return;
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Something is wrong.', backgroundColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBarFailed(context, 'The password provided is too weak.');

        Fluttertoast.showToast(msg: '', backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        showSnackBarFailed(
            context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        User? user = FirebaseAuth.instance.currentUser;

            screenPushRep(context, const CustomBottomNavigation());
          Fluttertoast.showToast(
              msg: 'Welcome back.', backgroundColor: Colors.red);
      } else {
        showSnackBarFailed(context, 'Something is wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBarFailed(context, 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        showSnackBarFailed(context, 'Password is wrong');
      }
    }
  }



  forgotPassword(String email,BuildContext context)async{
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).whenComplete((){
      showSnackBarSuccess(context,'Check your inbox and reset your password' );
    });
  }


}
