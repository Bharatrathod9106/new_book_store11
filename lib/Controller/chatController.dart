import 'package:bookstore/Model/ChatModel.dart';
import 'package:bookstore/Model/authmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callApi();
  }

  callApi() async {
    await GetChatUserList();
  }

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxList<UserModel> userChatList = <UserModel>[].obs;

  Future GetChatUserList() async {
    print('START');
    try {
      userChatList.clear();
      QuerySnapshot snapshot = await db
          .collection('users')
          // .where('id', isNotEqualTo: auth.currentUser!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        List<UserModel> data = snapshot.docs
            .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        userChatList.assignAll(data);
      } else {
        userChatList.clear();
      }
    } catch (e) {
      print('ERROR');
      userChatList.clear();
      print(e.toString());
    } finally {
      update();
    }
  }

  ////////////////////////////////////////////////////
  TextEditingController messageController = TextEditingController();

  Future StoreMessage(userId) async {
    String uuid = Uuid().v4();
    Map<String, dynamic> chatModel = ChatModel(
            senderId: auth.currentUser!.uid,
            recieverId: userId,
            Senttime: DateTime.now().toString(),
            chatText: messageController.text.toString(),
            messageId: uuid)
        .toJson();

    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .doc(uuid)
        .set(chatModel);

    await db
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(uuid)
        .set(chatModel);
    messageController.clear();
  }

  RxList<ChatModel> chatList = <ChatModel>[].obs;
  ScrollController scrollController = ScrollController();

  fetchChats(id) async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(id)
        .collection('messages')
        .orderBy('Senttime', descending: false)
        .snapshots()
        .listen((snapshot) {
      var ChatList = snapshot.docs
          .map((e) => ChatModel.fromJson(
                e.data() as Map<String, dynamic>,
              ))
          .toList();
      chatList.assignAll(ChatList);
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
