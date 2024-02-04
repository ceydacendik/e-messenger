// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class textFormField extends StatefulWidget {
  final String labeltext;
  final Icon icon;
  final TextEditingController? controller;
  final Function(String)? validator;
  final bool obsecureText;
  const textFormField({
    Key? key,
    required this.labeltext,
    required this.icon,
    this.controller,
    this.validator,
    required this.obsecureText,
  }) : super(key: key);

  @override
  State<textFormField> createState() => _textFormFieldState();
}

class _textFormFieldState extends State<textFormField> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05),
      child: Container(
        height: screenSize.height * 0.075,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white),
        child: TextFormField(
          obscureText: widget.obsecureText,
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            labelText: widget.labeltext,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
