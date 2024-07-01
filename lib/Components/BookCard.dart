// ignore_for_file: must_be_immutable

import 'package:bookstore/Controller/BookController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookCard extends StatelessWidget {
  final String coverUrl;
  final String title;
  final VoidCallback ontap;

   BookCard(
      {Key? key,
      required this.coverUrl,
      required this.title,
      required this.ontap})
      : super(key: key);

  BookController bb = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: ontap,
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  )
                ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 140,
                      imageUrl: coverUrl,
                      fit: BoxFit.cover,
                      width: 120,
                      errorWidget: (b, o, s) {
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                    )),
              ),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
