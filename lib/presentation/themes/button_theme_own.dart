import 'package:flutter/material.dart';
import './color_schema.dart';

class ButtonThemeOwn {
  static final ElevatedButtonThemeData primaryButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorSchema.primaryColor,
      foregroundColor: ColorSchema.onPrimaryColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

}