// ignore_for_file: must_be_immutable

import 'package:bookstore/Components/MyBackButton.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Controller/chatController.dart';
import 'package:bookstore/Pages/Chat_dir/Chat_Message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  ChatController cc = Get.find<ChatController>();
  BookController bb = Get.find<BookController>();

  final String coverUrl;
  final String title;
  final String author;

  final String description;
  final String name;
  final String image;
  final String rating;
  final String pages;
  final String language;
  final String audiolen;
  final String BookId;
  final String uid;
  final bool yes;

  HeaderWidget(
      {Key? key,
      required this.coverUrl,
      required this.title,
      required this.author,
      required this.description,
      required this.rating,
      required this.pages,
      required this.language,
      required this.audiolen,
      required this.yes,
      required this.uid,
      required this.name,
      required this.image, required this.BookId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackButton(),
            Row(
              children: [
                yes != true
                    ? GestureDetector(
                        onTap: () async {
                          await bb.deleteBook(BookId);
                          Get.back();
                        },
                        child: Icon(Icons.delete))
                    : SizedBox(),
                SizedBox(
                  width: 10,
                ),
                yes == true
                    ? GestureDetector(
                        onTap: () async {
                          await cc.fetchChats(uid.toString());
                          Get.to(() => ChatMessageScreen(
                                id: uid.toString(),
                                image: image,
                                name: name,
                              ));
                        },
                        child: Icon(Icons.message_outlined))
                    : SizedBox(),
                // SizedBox(
                //   width: 10,
                // ),
                // SvgPicture.asset(
                //   "Assets/Icons/heart.svg",
                //   color: Theme.of(context).colorScheme.onBackground,
                // ),
              ],
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: coverUrl,
                  width: 120,
                  fit: BoxFit.cover,
                ))
          ],
        ),
        SizedBox(height: 30),
        Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        Text(
          "Author : $author",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Rating",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  rating,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Pages",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  pages,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Language",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  language,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Audio",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  audiolen,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
