import 'package:flutter/material.dart';

class MultiLineTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MultiLineTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
