class User {
  int? id;
  String? email;
  String? password;
  String? name;
  String? imageUrl;
  String? phoneno;

  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.imageUrl,
    this.phoneno,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'imageurl': imageUrl,
      'phoneno': phoneno,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      imageUrl: map['imageurl'],
      phoneno: map['phoneno'],
    );
  }
}
