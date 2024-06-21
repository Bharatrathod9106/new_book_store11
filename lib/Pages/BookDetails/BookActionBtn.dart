import 'package:bookstore/Pages/BookPage/BookPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class BookActionBtn extends StatelessWidget {
  final String bookUrl;
  const BookActionBtn({Key? key, required this.bookUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.to(() => BookPage(bookUrl: bookUrl,));
            },
            child: Row(children: [
              SvgPicture.asset("Assets/Icons/book.svg",),
              SizedBox(width: 10),
              Text(
                "READ BOOK",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                  color:
                  Theme.of(context).colorScheme.onBackground,
                  letterSpacing: 1.2,
                ),
              ),
            ]),
          ),
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          Row(children: [
            SvgPicture.asset("Assets/Icons/playe.svg"),
            SizedBox(width: 10),
            Text(
              "PLAY BOOK",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color:
                Theme.of(context).colorScheme.onBackground,
                letterSpacing: 1.2,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
