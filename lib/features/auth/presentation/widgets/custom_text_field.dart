import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class custom_text_field extends StatefulWidget {
  const custom_text_field({super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,});


  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  State<custom_text_field> createState() => _custom_text_fieldState();
}

class _custom_text_fieldState extends State<custom_text_field> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(),
        cursorColor: AppColors.primary,
        cursorHeight: 20,
        // validator: (value) {},
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: AppColors.primary
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: AppColors.primary
              )
          ),
          // suffixIcon: isPassword ? FaIcon(FontAwesomeIcons.eye,) : null,
          suffixIcon: widget.isPassword ?
          Icon(
            CupertinoIcons.eye,
            color: AppColors.primary,
          ) : null,

          hintText: widget.hintText,
          fillColor: Colors.white,
          filled: true,
        )
    );
  }
}
