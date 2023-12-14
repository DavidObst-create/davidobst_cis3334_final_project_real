import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message {

  @HiveField(0)
  String messageText = "";

  @HiveField(1)
  bool isBotMessage = false;

  Message(this.messageText, this.isBotMessage);
}