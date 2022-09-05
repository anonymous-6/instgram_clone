// ignore_for_file: prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType? textInputType;
  final bool? isPass;
  TextFieldInput(
      {Key? key,
      this.hintText,
      this.isPass = false,
      this.textEditingController,
      this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder,
          focusedBorder: InputBorder,
          enabledBorder: InputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass!,
    );
  }
}
