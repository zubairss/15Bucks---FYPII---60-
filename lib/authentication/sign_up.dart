import 'package:email_validator/email_validator.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/firebase_interaction/auth.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerfullName = TextEditingController();
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
          height: size.height,
          margin: EdgeInsets.symmetric(horizontal: size.width*0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.23,
              ),
              Text(
                "Create Account",
                style: GoogleFonts.cabin(
                    color: Colors.black,
                    fontSize: size.width * 0.09,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                width: size.width * 0.8,
                child: TextField(
                  autofocus: false,
                  controller: _controllerfullName,
                  decoration: const InputDecoration(
                    hintText: "Enter your full name",
                  ),
                ),
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
              SizedBox(
                height: size.height * 0.04,
              ),
              InkWell(
                onTap: () {
                  signUp(context);
                },
                child: Hero(
                  tag: 'login',
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppConstants().primaryColor,
                          borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.017),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height * 0.02,
                          left: size.width*0.4),
                      width: size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SIGN UP",
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.043),
                          ),
                          SizedBox(
                            width: size.width*0.02,
                          ),
                          Icon(Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: size.width*0.04,
                          )
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: InkWell(
          onTap: (){
            goBackPreviousScreen(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?",style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(
                width: 10,
              ),
              Text("Sign in",style: GoogleFonts.cabin(
                  color: AppConstants().primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width*0.045
              ),),
            ],
          ),
        ),
      ),

    ));
  }

  signUp(BuildContext context) {
    if (_controllerfullName.text.replaceAll(' ', '').length < 3) {
      showSnackBarFailed(context, 'Name is short');
    } else if (!EmailValidator.validate(
        _controllerEmail.text.replaceAll(' ', ''))) {
      showSnackBarFailed(context, 'Email is not valid');
    } else if (_controllerPassword.text.replaceAll(' ', '').length < 4) {
      showSnackBarFailed(context, 'Password is short');

      Fluttertoast.showToast(msg: '', backgroundColor: Colors.red);
    } else {
      AuthOperations().signUp(context, _controllerEmail.text,
          _controllerPassword.text, _controllerfullName.text);
    }
  }

}
