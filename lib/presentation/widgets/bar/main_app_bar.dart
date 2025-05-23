import 'package:burning_bros/core/styles/color.dart';

import 'package:flutter/material.dart';

class CustomMealAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isHaveSearchField;
  const CustomMealAppBar({
    super.key,
    this.isHaveSearchField
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        color: mainColor, // mint green
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
            child: Center(
              child: Text(
                'List Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white,
                ),
              ),
            )
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(80);
}