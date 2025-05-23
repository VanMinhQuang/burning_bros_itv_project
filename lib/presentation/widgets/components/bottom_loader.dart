import 'package:flutter/material.dart';

class BotLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator()
        ),
      ),
    );
  }
}