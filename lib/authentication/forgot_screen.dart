import 'package:fifteenbucks/firebase_interaction/auth.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.26,
                ),
                Text(
                  "Forgot password?",
                  style: TextStyle(
                    fontSize: size.width * 0.067,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  "Enter your email and reset your password",
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TextField(
                  controller: _controller,
                  decoration:
                      const InputDecoration(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    AuthOperations().forgotPassword(_controller.text, context);
                  },
                  child: Hero(
                    tag: 'Send',
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppConstants().primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                          vertical: size.height * 0.017),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: size.height * 0.02, left: size.width * 0.54),
                      width: size.width * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Send",
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
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
