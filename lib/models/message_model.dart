class SocialMessageModel {
  String? senderId;
  String? receiverId;
  String? text;
  String? dateTime;

  SocialMessageModel({
    this.text,
    this.senderId,
    this.dateTime,
    this.receiverId,
  });

  SocialMessageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
