import 'package:flutter/material.dart';

class TextFiledd extends StatelessWidget {
  TextFiledd({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  });

  final TextEditingController controller;
  bool obscureText;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) => value!.isEmpty ? 'invalid this required' : null,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
