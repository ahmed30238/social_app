class SocialPostsModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? postImage;
  String? dateTime;

  SocialPostsModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.postImage,
    this.dateTime,
  });

  SocialPostsModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'postImage': postImage,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
