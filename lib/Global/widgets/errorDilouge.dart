import 'package:flutter/material.dart';
import 'package:weight_o_gram/Global/Colors/Colors.dart';

class DefaultErrorDialog {
  static Future<void> showErrorDialog(
      {BuildContext context,
      String title = 'Failed !',
      String message = 'Some thing went wrong!\nPlease try again.'}) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: blackColor(),
            fontSize: 24,
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle,
              color: bgLightColor(),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
