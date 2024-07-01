// ignore_for_file: must_be_immutable

import 'package:bookstore/Components/BookTile.dart';
import 'package:bookstore/Components/MyBackButton.dart';
import 'package:bookstore/Components/myAlertBox.dart';
import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Pages/AddNewBook/AddNewBook.dart';
import 'package:bookstore/Pages/BookDetails/BookDetails.dart';
import 'package:bookstore/Pages/ProfilePage/EditProfile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Auth/LoginScreen.dart';
import '../../Auth/utils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  BookController bb = Get.find<BookController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewBook());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: RefreshIndicator(onRefresh: ()async{
        await bb.callApi();
      },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 500
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyBackButton(),
                              Text(
                                "PROFILE",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              ),
                              // SizedBox(width: 10),
                              IconButton(
                                  onPressed: () async {
                                    Get.dialog(CustomAlert(
                                      title: 'Confirm Logout',
                                      content:
                                          'Are you sure you want to log out?',
                                      positiveText: 'Yes',
                                      negativeText: 'No',
                                      onConfirm: () async {
                                        await auth
                                            .signOut()
                                            .onError((error, stackTrace) {
                                          utils().toastMessage(error.toString());
                                        });
                                        Get.offAll(() => LoginScreen());
                                        utils().toastMessage('Logged Out');
                                      },
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.logout_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                  ))
                            ],
                          ),
                          SizedBox(height: 80),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                            child: Obx(() {
                              if (bb.userDataList.isEmpty) {
                                return SizedBox();
                              }
                              return GestureDetector(
                                onTap: () async {
                                  bb.bigSize.toggle();
                                },
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  height: bb.bigSize.value ? 200 : 120,
                                  width: bb.bigSize.value ? 200 : 120,
                                  duration: Duration(milliseconds: 500),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            bb.userDataList[0].profile.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (b, o, s) {
                                          return Center(
                                            child: Icon(Icons.error),
                                          );
                                        },
                                      )),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          Obx(() => bb.userDataList.isEmpty
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      bb.userDataList[0].fullName.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          bb.fullNameController.text = bb
                                              .userDataList[0].fullName
                                              .toString();
                                          bb.numberController.text = bb
                                              .userDataList[0].number
                                              .toString();
                                          bb.imageee.value = bb
                                              .userDataList[0].profile
                                              .toString();
                                          Get.to(() => EditProfile(),
                                              transition: Transition.rightToLeft);
                                        },
                                        child: Icon(Icons.edit))
                                  ],
                                )),
                          SizedBox(height: 10),
                          Obx(() => bb.userDataList.isEmpty
                              ? SizedBox()
                              : Text(
                                  bb.userDataList[0].email.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Your Books",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    GetBuilder<BookController>(builder: (bb) {
                      if (bb.mybooklist.isEmpty) {
                        return Center(
                          child: Text('No Data Found'),
                        );
                      } else {
                        return Column(
                            children:
                                List.generate(bb.mybooklist.length, (index) {
                          var d = bb.mybooklist[index];

                          return BookTile(
                            title: d.title,
                            coverUrl: d.coverUrl,
                            author: d.author,
                            price: d.price,
                            rating: d.rating,
                            totalRating: d.numberOfRating.toString(),
                            ontap: () {
                              Get.to(BookDetails(
                                book: d,
                              ));
                            },
                          );
                        }));
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
