import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.back();
      },
      child: Row(
        children: [
          SvgPicture.asset("Assets/Icons/back.svg"),
          SizedBox(width: 10),
          Text(
            "Back",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface),
          ),
        ],
      ),
    );
  }
}
