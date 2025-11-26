import 'package:flutter/material.dart';

class TextImput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TextImput({super.key, required this.controller,required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      keyboardType: TextInputType.text,
    );
  }
}