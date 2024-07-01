// ignore_for_file: must_be_immutable

import 'package:bookstore/Controller/chatController.dart';
import 'package:bookstore/Model/bookModel.dart';
import 'package:bookstore/Pages/BookDetails/BookActionBtn.dart';
import 'package:bookstore/Pages/BookDetails/HeaderWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;
  final auth = FirebaseAuth.instance;

  BookDetails({Key? key, required this.book}) : super(key: key);
  ChatController cc = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              // height: 500,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
              child: Row(
                children: [
                  Expanded(
                    child: HeaderWidget(
                      coverUrl: book.coverUrl,
                      title: book.title,
                      author: book.author,
                      description: book.description,
                      rating: book.rating,
                      pages: book.pages.toString(),
                      language: book.language.toString(),
                      audiolen: book.audioLen,
                      yes: book.userID == auth.currentUser!.uid ? false : true,
                      uid: book.userID,
                      image: cc.userChatList
                          .firstWhere((element) => element.id == book.userID)
                          .profile
                          .toString(),
                      name: cc.userChatList
                          .firstWhere((element) => element.id == book.userID)
                          .fullName
                          .toString(), BookId:book.BookID.toString(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "About Book",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          book.description,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "About Author",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          book.aboutAuthor,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BookActionBtn(
                    bookUrl: book.bookUrl.toString(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
