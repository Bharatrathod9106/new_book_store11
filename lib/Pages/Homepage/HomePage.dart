// ignore_for_file: must_be_immutable

import 'package:bookstore/Components/BookCard.dart';
import 'package:bookstore/Components/BookTile.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Model/Data.dart';
import 'package:bookstore/Pages/BookDetails/BookDetails.dart';
import 'package:bookstore/Pages/Homepage/Widgets/AppBar.dart';
import 'package:bookstore/Pages/Homepage/Widgets/CategoryWidget.dart';
import 'package:bookstore/Pages/Homepage/Widgets/MyInputTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  BookController bb = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await bb.GetAllBooks();
          Fluttertoast.showToast(
              msg: "Refreshed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).colorScheme.primary,
                height: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          HomeAppBar(),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Text(
                                "Good Morning ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                              Text(
                                "! Novel Nest !",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "time to read book and enhance your knowledge",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          MyInputTextField(
                            onChanged: (val) {
                              bb.filterProductScreen();
                            },
                            controller: bb.searchController,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Topic",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoryData
                                  .map(
                                    (e) => CategoryWidget(
                                        iconPath: e["icon"]!,
                                        btnName: e["lebel"]!),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Treding",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: GetBuilder<BookController>(builder: (bb) {
                        if (bb.bookList.isEmpty) {
                          return Center(
                            child: Text('No Data Found'),
                          );
                        } else {
                          return Row(
                              children: List.generate(
                            bb.bookList.length,
                            (index) => BookCard(
                              title: bb.bookList[index].title,
                              coverUrl: bb.bookList[index].coverUrl,
                              ontap: () {
                                Get.to(BookDetails(
                                  book: bb.bookList[index],
                                ));
                              },
                            ),
                          ));
                        }
                      }),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Your Interests",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    GetBuilder<BookController>(builder: (bb) {
                      if (bb.bookList.isEmpty) {
                        return Center(
                          child: Text('No Data found'),
                        );
                      } else {
                        return Column(
                            children: List.generate(
                                bb.bookList.length,
                                (index) => BookTile(
                                      title: bb.bookList[index].title,
                                      coverUrl: bb.bookList[index].coverUrl,
                                      author: bb.bookList[index].author,
                                      price: bb.bookList[index].price,
                                      rating: bb.bookList[index].rating,
                                      totalRating: bb
                                          .bookList[index].numberOfRating
                                          .toString(),
                                      ontap: () {
                                        Get.to(BookDetails(
                                          book: bb.bookList[index],
                                        ));
                                      },
                                    )));
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
