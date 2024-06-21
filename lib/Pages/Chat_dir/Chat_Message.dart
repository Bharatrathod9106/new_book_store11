import 'package:bookstore/Components/MyTextFormField.dart';
import 'package:bookstore/Controller/chatController.dart';
import 'package:bookstore/Model/authmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatMessageScreen extends StatelessWidget {
  ChatMessageScreen(
      {super.key,
      required this.id,
      required this.image,
      required this.name});

  final String image;
  final String name;
  final String id;
  ChatController rc = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    var mySize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: image,
              errorWidget: (b, o, s) {
                return Icon(Icons.person);
              },
            ),
          )
        ],
        title: Text(name),
      ),
      body: Container(
        width: mySize.width,
        height: mySize.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                controller: rc.scrollController,
                shrinkWrap: true,
                itemCount: rc.chatList.length,
                itemBuilder: (context, index) {
                  var messageText = rc.chatList[index].chatText;
                  var messageSender = rc.chatList[index]
                      .senderId; // Assuming 'senderId' is the UID
                  var isCurrentUser = messageSender == rc.auth.currentUser!.uid;

                  return messageSender == rc.auth.currentUser!.uid
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Card(
                              color: Colors.green.shade300,
                              surfaceTintColor: Colors.white,
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 0,
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width / 1.3),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Text(
                                  messageText,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Card(
                              color: Colors.white60,
                              surfaceTintColor: Colors.white,
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 0,
                                    maxWidth:
                                        MediaQuery.sizeOf(context).width / 1.3),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Text(messageText),
                              ),
                            ),
                          ),
                        );
                },
              );
            })),
            Row(
              children: [
                Expanded(
                    child: MyTextFormField(
                        hintText: 'Enter Message',
                        icon: Icons.message,
                        controller: rc.messageController)),
                IconButton(
                    onPressed: () async {
                      if (rc.messageController.text.isNotEmpty &&
                          rc.messageController.text.length < 3000) {
                        await rc.StoreMessage(id);
                      }
                    },
                    icon: const Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
