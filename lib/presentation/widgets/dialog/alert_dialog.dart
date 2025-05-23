import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';

class CustomDialog{
  static void showErrorAlert(
      {required BuildContext context, required String content}) {
    Dialogs.materialDialog(
      context: context,
      msg: content,
      customView: Column(
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: errorIcon,
          ),
          SizedBox(height: 16),
          Text(
            'Error Occurred',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Something went wrong. Please try again.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      dialogShape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}