import 'package:flutter/material.dart';

class RadioButtonAtom extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const RadioButtonAtom({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: groupValue,
      onChanged: (newValue) => onChanged(newValue!),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}
