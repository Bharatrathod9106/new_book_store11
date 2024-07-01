import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryWidget extends StatelessWidget {
  final String iconPath;
  final String btnName;
  const CategoryWidget({Key? key, required this.iconPath, required this.btnName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: 10),
              Text(btnName),
            ],
          ),
        ),
      ),
    );
  }
}
