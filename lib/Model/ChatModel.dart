class ChatModel {
  dynamic senderId;
  dynamic recieverId;
  dynamic Senttime;
  dynamic chatText;
  dynamic messageId;

  ChatModel({
    required this.senderId,
    required this.recieverId,
    required this.Senttime,
    required this.chatText,
    required this.messageId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
        senderId: json['senderId'],
        recieverId: json['recieverId'],
        Senttime: json['Senttime'],
        chatText: json['chatText'],
        messageId: json['mesageId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['recieverId'] = this.recieverId;
    data['Senttime'] = this.Senttime;
    data['chatText'] = this.chatText;
    data['mesageId'] = this.messageId;

    return data;
  }
}
