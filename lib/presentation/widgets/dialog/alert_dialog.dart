import 'package:burning_bros/core/styles/text_style.dart';
import 'package:burning_bros/data/constant/constant_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CustomDialog {
  static void showErrorAlert(
      {required BuildContext context, required String content}) {
    Dialogs.materialDialog(
      context: context,
      msg: content,
      customView: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 60.sp,
            width: 60.sp,
            child: errorIcon,
          ),
          SizedBox(height: 16),
          Text(
            'Error Occurred',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actionsBuilder: (context) {
        return [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent[100], // Custom background color
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextThemeStyle.textBoxCustomSize(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ];
      },
      dialogShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
