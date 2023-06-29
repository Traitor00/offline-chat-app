class Combined {
  String? message;
  String? updatedat;
  String? name;
  String? imageUrl;
  String? phoneno;
  int? recieverid;
  int? senderid;
  String? img;
  String? reaction;
  int? id;

  Combined({
    this.message,
    this.updatedat,
    this.name,
    this.imageUrl,
    this.recieverid,
    this.senderid,
    this.img,
    this.phoneno,
    this.reaction,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'updatedat': updatedat,
      'name': name,
      'imageurl': imageUrl,
      'recieverid': recieverid,
      'senderid': senderid,
      'img': img,
      'phoneno': phoneno,
      'reaction': reaction,
      'id': id
    };
  }

  factory Combined.fromMap(Map<String, dynamic> map) {
    return Combined(
        message: map['message'],
        updatedat: map['updatedat'],
        name: map['name'],
        imageUrl: map['imageurl'],
        recieverid: map['recieverid'],
        senderid: map['senderid'],
        img: map['img'],
        phoneno: map['phoneno'],
        reaction: map['reaction'],
        id: map['id']);
  }
}
