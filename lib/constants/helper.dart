import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_engineer/constants/app_colors.dart';

class Utils {

  static const msgrequiredField = "Please fill empty details";
  static const msgEnterValidEmail = "Please enter valid email address";
  static const actionEmployees = 'actionEmployees';
  static const sharedPrefrencesEmployeeKey = 'employees';

  static void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: 14,
        backgroundColor: AppColors.black,
        textColor: AppColors.white);
  }

  static bool isValidEmail(String em) {
    //String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static void showTwoButtonAlertDialog(
      {required BuildContext context,
        required String alertTitle,
        required String alertMsg,
        required String positiveText,
        required String negativeText,
        required Function() yesTap}) {
    // set up the buttons
    Widget noButton = TextButton(
      child:  Text(
        negativeText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child:  Text(
        positiveText,
        style: TextStyle(
          fontSize: 16.0,
          color: AppColors.black,
        ),
      ),
      onPressed: (){
        Navigator.of(context).pop();
        yesTap();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertMsg),
      actions: [
        noButton,
        yesButton
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
