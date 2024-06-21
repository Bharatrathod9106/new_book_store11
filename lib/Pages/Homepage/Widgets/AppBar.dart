import 'package:bookstore/Config/colors.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Pages/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({Key? key}) : super(key: key);
  BookController bb = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("Assets/Icons/dashboard.svg"),
        Text(
          "Novel Nest",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => ProfilePage());
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: Obx(() => bb.userDataList.isEmpty
                ? Text('')
                : Text(
                    bb.userDataList[0].fullName![0].toUpperCase(),
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  )),
          ),
        ),
      ],
    );
  }
}
