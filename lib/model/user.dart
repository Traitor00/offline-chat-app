class User {
  int? id;
  String? email;
  String? password;
  String? name;
  String? imageUrl;

  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'imageurl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      imageUrl: map['imageurl'],
    );
  }
}
