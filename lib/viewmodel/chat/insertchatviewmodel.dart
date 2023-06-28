import 'package:chatapp/helpers/databasehelpers.dart';
import 'package:chatapp/model/combined.dart';
import 'package:chatapp/model/message.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatProvider extends ChangeNotifier {
  int? _senderId;
  int? _receiverId;

  int get senderId => _senderId!;
  int get receiverId => _receiverId!;

  set senderId(int senderId) {
    _senderId = senderId;
  }

  set receiverId(int receiverId) {
    _receiverId = receiverId;
  }

  ///Text Editing Controller for message textfield
  TextEditingController messageController = TextEditingController();
  dynamic imagetemporary;

  ///Function to pick Image
  Future getimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagetemporary = image.path;
    this.imagetemporary = imagetemporary;
  }

  ///function to clear selected image but it donot work
  void clearSelectedImage() {
    imagetemporary = null;
  }

  ///Function to send message data to database
  void doChat() async {
    String messagetext = messageController.text;
    messageController.clear();

    DatabaseHelper dbHelper = DatabaseHelper();
    final Message message = Message(
        message: messagetext,
        senderId: senderId,
        recieverid: receiverId,
        updatedAt: DateTime.now().toIso8601String(),
        img: imagetemporary);
    imagetemporary = null;

    ///to make the image selected  to null  so that no same image cant be inserted to null image
    await dbHelper.insertMessage(message);

    notifyListeners();
  }

  /// Function fo fetch message in chat page
  Future<List<Combined>> messageFetch() async {
    DatabaseHelper dbHelper = DatabaseHelper();

    return await dbHelper.fetchConversation(senderId, receiverId);
  }
}
