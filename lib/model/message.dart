class Message {
  int? id;
  int? senderId;
  int? recieverid;
  String? message;
  String? updatedAt;
  String? img;
  String? reaction;

  Message({
    this.id,
    this.senderId,
    this.recieverid,
    this.message,
    this.updatedAt,
    this.img,
    this.reaction,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderid': senderId,
      'recieverid': recieverid,
      'message': message,
      'updatedat': updatedAt,
      'img': img,
      'reaction': reaction
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      senderId: map['senderid'],
      recieverid: map['recieverid'],
      message: map['message'],
      updatedAt: map['updatedat'],
      img: map['img'],
      reaction: map['reaction'],
    );
  }
}
