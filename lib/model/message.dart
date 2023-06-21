import 'dart:io';
import 'dart:typed_data';

class Message {
  int? id;
  int? senderId;
  int? recieverid;
  String? message;
  String? updatedAt;
  String? img;

  Message(
      {this.id,
      this.senderId,
      this.recieverid,
      this.message,
      this.updatedAt,
      this.img});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderid': senderId,
      'recieverid': recieverid,
      'message': message,
      'updatedat': updatedAt,
      'img': img
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        id: map['id'],
        senderId: map['senderid'],
        recieverid: map['recieverid'],
        message: map['message'],
        updatedAt: map['updatedat'],
        img: map['img']);
  }
}
