import 'package:burning_bros/core/styles/color.dart';
import 'package:burning_bros/core/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnSearchTextChange = void Function(String text);
typedef OnSubmitTextChange = void Function(String text);
typedef OnTapTextSearch = void Function();

class CustomSearchBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final OnSearchTextChange? onChange;
  final OnSubmitTextChange? onSubmit;
  final OnSubmitTextChange? onClear;
  final OnTapTextSearch? onTap;

  const CustomSearchBox(
      {super.key, required this.controller,
        required this.hintText,
        this.onChange,
        this.onSubmit,
        this.onClear,
        this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(

          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          color: Colors.white),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) =>  TextFormField(
          controller: controller,
          style: TextThemeStyle.textBoxCustomSize(
              color: Colors.black,  fontSize: 16.sp),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            border: InputBorder.none,
            hintStyle:  TextThemeStyle.textBoxCustomSize(
              color: textGrey,  fontSize: 16.sp),
            hintText: hintText,
            isCollapsed: true,
            prefixIcon:  Icon(Icons.search,
                color: textGrey, size: 16.sp),
            suffixIcon: value.text.isEmpty
                ? const SizedBox()
                : IconButton(
              onPressed: () {
                controller.clear();
                if(onClear != null){
                  onClear!('');
                }
                FocusScope.of(context).unfocus();
              },
              icon:  Icon(Icons.close,
                  color: Colors.black, size: 16.sp),
            ),
          ),
          onChanged: (text){
            if(onChange != null){
              onChange!(text);
            }
          },
          onTap: (){
            if(onTap != null){
              onTap!();
            }
          },
          onFieldSubmitted: (text) {
            if(onSubmit != null){
              //controller.text = text;
              onSubmit!(text);
            }
          },
        ),
      ),
    );
  }
}
