import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const BuildTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
