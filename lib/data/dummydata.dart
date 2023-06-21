import 'package:chatapp/model/message.dart';
import 'package:chatapp/model/user.dart';

final User currentUser = User(
  id: 1,
  name: 'John Doe',
  imageUrl: 'https://example.com/user1.jpg',
);

final User otherUser = User(
  id: 1,
  name: 'Jane Smith',
  imageUrl: 'https://example.com/user2.jpg',
);

final List<Message> dummyData = [
  Message(
    senderId: 1,
    recieverid: 2,
    message: 'Hello',
    updatedAt: DateTime.now().toIso8601String(),
  ),
  Message(
    senderId: 2,
    recieverid: 1,
    message: 'Hi',
    updatedAt: DateTime.now().add(Duration(minutes: 5)).toIso8601String(),
  ),
  Message(
    senderId: 1,
    recieverid: 2,
    message: 'How are you?',
    updatedAt: DateTime.now().add(Duration(minutes: 10)).toIso8601String(),
  ),
];
