import 'package:hive/hive.dart';
import 'package:davidobst_cis3334_final_project/message.dart';

part 'conversation.g.dart';

@HiveType(typeId: 0)
class Conversation {

  @HiveField(0)
  String topic = "";

  @HiveField(1)
  DateTime? dateCreated;

  @HiveField(2)
  List<Message> messages = <Message>[];

  Conversation(this.topic, this.dateCreated){
    addMessage("Test message", false);
    print("Conversation created");
  }

  void addMessage(String text, bool isBotMessage) {
    messages.add(Message(text, isBotMessage));
  }

  void removeMessage(int index) {
    messages.removeAt(index);
  }

  List<Messages> getMessages() {
    return messages;
  }
}