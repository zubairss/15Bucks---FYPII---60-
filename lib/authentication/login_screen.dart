import 'package:email_validator/email_validator.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/firebase_interaction/auth.dart';
import 'package:fifteenbucks/authentication/sign_up.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  int? roleValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                SizedBox(
                  height: size.height * 0.15,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'Please sign in to continue',
                  style: GoogleFonts.cabin(
                      color: Colors.grey.shade600,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextField(
                    autofocus: false,
                    controller: _controllerEmail,
                    decoration: const InputDecoration(
                      hintText: "Enter your email",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.02),
                  width: size.width * 0.8,
                  child: TextField(
                    autofocus: false,
                    controller: _controllerPassword,
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                    ),
                  ),
                ),
                InkWell(
                   onTap: (){
                    screenPush(context,ForgotScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: size.height*0.01),
                    width: size.width,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: AppConstants().primaryColor,
                          fontSize: size.width * 0.045),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                InkWell(
                  onTap: () {
                    signIn(context);
                  },
                  child: Hero(
                    tag: 'login',
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppConstants().primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.017),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: size.height * 0.02, left: size.width * 0.4),
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: GoogleFonts.cabin(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.045),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: size.width * 0.04,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: InkWell(
            onTap: () {
              screenPush(context, const SignUp());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Sign up",
                  style: GoogleFonts.cabin(
                      color: AppConstants().primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.045),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn(BuildContext context) {
    if (!EmailValidator.validate(_controllerEmail.text.replaceAll(' ', ''))) {
      showSnackBarFailed(context, 'Email is not valid');

      return;
    } else if (_controllerPassword.text.replaceAll(' ', '').length < 5) {
      showSnackBarFailed(context, 'Passsword is short');

      return;
    } else {
      AuthOperations().signIn(_controllerEmail.text.replaceAll(' ', ''),
          _controllerPassword.text.replaceAll(' ', ''), context);
    }
  }
}
