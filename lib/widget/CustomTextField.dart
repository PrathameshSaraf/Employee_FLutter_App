import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';


class CreateProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const CreateProfileTextField(
      {Key? key, required this.controller,this.hintText=''})
      : super(key: key);

  @override
  _CreateProfileTextFieldState createState() => _CreateProfileTextFieldState();
}

class _CreateProfileTextFieldState extends State<CreateProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      decoration: InputDecoration(
        fillColor: AppColors.white,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: BorderSide(color: AppColors.black),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
      validator: (value) {
        if (value!.isEmpty) return "Please enter this field";
        return null;
      },
    );
  }
}
