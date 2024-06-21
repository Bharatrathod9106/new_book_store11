import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyInputTextField extends StatelessWidget {
  MyInputTextField({Key? key, this.onChanged, required this.controller})
      : super(key: key);
  final void Function(String?)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          SvgPicture.asset("Assets/Icons/search.svg"),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Search here . .",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
