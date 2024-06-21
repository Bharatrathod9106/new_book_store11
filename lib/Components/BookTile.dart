import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookTile extends StatelessWidget {
  final String title;
  final String coverUrl;
  final String author;
  final int price;
  final String rating;
  final String totalRating;
  final VoidCallback ontap;

  const BookTile({
    Key? key,
    required this.title,
    required this.coverUrl,
    required this.author,
    required this.price,
    required this.rating,
    required this.totalRating,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  )
                ]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: coverUrl,
                      width: 120,
                      fit: BoxFit.cover,
                      errorWidget: (b,o,s){
                        return Center(child: Icon(Icons.error,color: Colors.red,),);
                      },
                    )),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "By : $author",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Price : $price",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("Assets/Icons/star.svg"),
                        Text(
                          rating,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "($totalRating ratings)",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    )
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
