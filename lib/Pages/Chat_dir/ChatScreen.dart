// ignore_for_file: must_be_immutable

import 'package:bookstore/Config/colors.dart';
import 'package:bookstore/Controller/chatController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  ChatController cc = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    var mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Chat Screen'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: mySize.height,
        width: mySize.width,
        child: GetBuilder<ChatController>(builder: (cc) {
          if (cc.userChatList.isEmpty) {
            return Center(
              child: Text('No Users'),
            );
          } else {
            return ListView.builder(
                itemCount: cc.userChatList.length,
                itemBuilder: (context, index) {
                  var d = cc.userChatList[index];
                  return Card(
                    surfaceTintColor: Colors.grey.shade400,
                    elevation: 3,
                    child: ListTile(
                      onTap: () async {
                        await cc.fetchChats(d.id.toString());
                        // Get.to(() =>
                        //     ChatMessageScreen(user: d, id: d.id.toString()));
                      },
                      leading: Hero(
                        tag: d.profile.toString(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: CachedNetworkImage(
                            imageUrl: d.profile.toString(),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorWidget: (b, o, s) {
                              return Center(
                                child: Icon(Icons.person),
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(d.fullName.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.message),
                          Icon(Icons.arrow_forward_ios_outlined)
                        ],
                      ),
                    ),
                  );
                });
          }
        }),
      ),
    );
  }
}
