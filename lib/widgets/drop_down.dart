import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;

  const AppDropdownInput({
    Key? key,
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            enabledBorder:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            border:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              dropdownColor: Colors.white,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    getLabel(value),
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
