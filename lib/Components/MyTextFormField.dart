import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isNumber;
  final TextEditingController controller;

  const MyTextFormField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.isNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters:
          isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        filled: true,
        hintText: hintText,
        prefixIcon:
            Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
