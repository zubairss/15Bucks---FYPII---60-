import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text,style: TextStyle(
      fontSize: 15
    ),),
    backgroundColor: Colors.green.shade600,
  ));
}

showSnackBarFailed(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text, style: TextStyle(
        fontSize: 15
    ),),
    backgroundColor: Colors.red.shade600,
  ));
}
