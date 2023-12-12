import 'dart:developer';

import 'package:davidobst_cis3334_final_project/message.dart';


class Conversation {

  String topic = "";
  String date = "";
  List<Message> messages = <Message>[];

  Conversation(this.topic, this.date){
    addMessage("Test message", false);
    print("Conversation created");
  }

  void addMessage(String text, bool isBotMessage) {
    messages.add(Message(text, isBotMessage));
  }

  void removeMessage(int index) {
    messages.removeAt(index);
  }
}