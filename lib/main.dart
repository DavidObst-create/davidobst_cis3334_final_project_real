import 'package:davidobst_cis3334_final_project/conversation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:davidobst_cis3334_final_project/message.dart';
import 'package:split_view/split_view.dart';


const conversationsBox = 'conversations';
const List<Conversation> conversations = [

];

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter<Conversation>(ConversationAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Conversation>(conversationsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'OpenAI-API flutter demo'),
    );
  }
}

//------------------------------------------------------------------------------



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key)

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//------------------------------------------------------------------------------

class _MyHomePageState extends State<MyHomePage> {
List<Message> messages = <Message>[];

List<Conversation> conversations = <Conversation>[];
bool isBotThinking = false;

Message testMessage = new Message("Test text", false);
Conversation testConversation = new Conversation("Test topic", DateTime.now());
Conversation currentConvo = conversations[0];

  void createMessage() {
    setState(() {
      messages = conversations[0].getMessages();
      print("Messages list length is " + messages.length.toString());
      if (isBotThinking == false) {
        currentConvo = conversations[0];
        currentConvo.addMessage("Human message", false);
        isBotThinking = true;
      }
      else {
        currentConvo = conversations[0];
        currentConvo.addMessage("Bot message", true);
        isBotThinking = false;
      }
      messages = conversations[0].getMessages();
      print("Messages list length is " + messages.length.toString());
}
    );


  }

@override
Widget build(BuildContext context) {

  conversations.add(testConversation);

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ),

    body: Column(
      children: <Widget>[
        Expanded(
          child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              indicator: SplitIndicator(viewMode: SplitViewMode.Horizontal),
              activeIndicator: SplitIndicator(
                viewMode: SplitViewMode.Horizontal,
                isActive: true,
              ),
              children: [
                Container(
                    child: ListView.builder(
                      itemCount: conversations.length,
                      itemBuilder: (BuildContext context, int position) {
                        print("Conversations list length is " + conversations.length.toString());
                        return ListTile(
                          title: Text(conversations[position].topic),
                          tileColor: Colors.green,
                        );
                      },
                    )
                ),
                Container(
                    child: ListView.builder(
                      itemCount: currentConvo.messages.length,
                      itemBuilder: (BuildContext context, int position) {
                        Message message = currentConvo.messages[position];
                        return ListTile(
                          title: Text(message.messageText),
                          tileColor: Colors.green, //TODO create a stateful color object in the create conversation method that changes depending on the isBotThinking bool
                        );
                      },
                    )
                ),
              ]
          ),
        ),
        Container(
          child: Column(
            children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New Message',
              ),
              controller: TextEditingController(),
            ),
            ElevatedButton(
              onPressed: () async {
                final message = Message("Test message", false);
                if (message != null) {
                  //await Hive.box<Conversation>(conversationsBox).add(message);
                  //print("Message added");
                }
                  setState(() {});
              },
              child: const Text('Send'),
            ),
            ]
          )
        )
      ],
    ),
  );
}
}


//------------------------------------------------------------------------------
//Hive Code
