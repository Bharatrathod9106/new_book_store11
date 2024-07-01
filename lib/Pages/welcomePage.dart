// ignore_for_file: must_be_immutable

import 'package:bookstore/Controller/BookController.dart';
import 'package:bookstore/Controller/NavigationController.dart';
import 'package:bookstore/Pages/Chat_dir/ChatScreen.dart';
import 'package:bookstore/Pages/Homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AddNewBook/AddNewBook.dart';
import 'ProfilePage/ProfilePage.dart';

class welcomePage extends StatelessWidget {
  welcomePage({Key? key}) : super(key: key);
  navigationController nn = Get.find<navigationController>();

  BookController bb = Get.find<BookController>();

  final tabs = [
    HomePage(),
    Center(child: Text("search")),
    AddNewBook(),
    ChatScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: tabs[nn.page.value],
          // body: Column(
          //   children: [
          //     Container(
          //       height: 500,
          //       padding: EdgeInsets.all(20),
          //       color: Theme.of(context).colorScheme.primary,
          //       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //         Expanded(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               const SizedBox(height: 50),
          //               Image.asset(
          //                 "Assets/Images/book.png",
          //                 width: 350,
          //               ),
          //               const SizedBox(height: 60),
          //               Text("E - Book Store",
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .headlineLarge
          //                       ?.copyWith(
          //                         color: Theme.of(context).colorScheme.background,
          //                       )),
          //               const SizedBox(height: 10),
          //               Flexible(
          //                 child: Text(
          //                     "Here you can find best book for you and you can also read book and listen book",
          //                     textAlign: TextAlign.center,
          //                     style: Theme.of(context)
          //                         .textTheme
          //                         .labelSmall
          //                         ?.copyWith(
          //                           color: Theme.of(context).colorScheme.background,
          //                         )),
          //               ),
          //             ],
          //           ),
          //         )
          //       ]),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Column(
          //         children: [
          //           const SizedBox(height: 10),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 "Disclaimer",
          //                 style: Theme.of(context).textTheme.labelMedium,
          //               ),
          //             ],
          //           ),
          //           const SizedBox(height: 10),
          //           Row(
          //             children: [
          //               Flexible(
          //                 child: Text(
          //                   "n publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum",
          //                   textAlign: TextAlign.center,
          //                   style: Theme.of(context).textTheme.labelSmall,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Spacer(),
          //     Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: PrimaryButton(
          //         btnName: "CONTINOUE",
          //         ontap: () {
          //           // Get.offAll(HomePage());
          //           Get.offAll(() => HomePage());
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: nn.page.value,
            type: BottomNavigationBarType.fixed,
            iconSize: 20,
            onTap: (index) {
              nn.page.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.onSurface),
                  label: 'Home',
                  backgroundColor: Theme.of(context).colorScheme.primary),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.onSurface),
                  label: 'Search',
                  backgroundColor: Theme.of(context).colorScheme.primary),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add,
                      color: Theme.of(context).colorScheme.onSurface),
                  label: 'Post',
                  backgroundColor: Theme.of(context).colorScheme.primary),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat,
                      color: Theme.of(context).colorScheme.onSurface),
                  label: 'chat',
                  backgroundColor: Theme.of(context).colorScheme.primary),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.onSurface),
                  label: 'Profile',
                  backgroundColor: Theme.of(context).colorScheme.primary),
            ],
          ));
    });
  }
}
