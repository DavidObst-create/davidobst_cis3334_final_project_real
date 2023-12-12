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
  await Hive.initFlutter();
  await Hive.openBox<String>(conversationsBox);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//------------------------------------------------------------------------------

class _MyHomePageState extends State<MyHomePage> {
List<String> messages = <String>[];

List<Conversation> conversations = <Conversation>[];
bool isBotThinking = false;

Message testMessage = new Message("Test text", false);
Conversation testConversation = new Conversation("Test topic", "Test date");
  void createMessage() {
    setState(() {

      if (isBotThinking == false) {
        messages.add("Hello, I am a chatbot. How can I help you?");
        messages.add("bool is " + isBotThinking.toString());
        isBotThinking = true;
      }
      else {
        messages.add("Human input goes here");
        messages.add("bool is " + isBotThinking.toString());
        isBotThinking = false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    conversations.add(testConversation);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: SplitView(
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
                  print("Length is " + conversations.length.toString());
                  return ListTile(
                    title: Text(conversations[position].topic),
                    tileColor: Colors.green,
                  );
                },
              )
          ),
          Container(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int position) {
                  return ListTile(
                    title: Text(messages[position]),
                    tileColor: Colors.green, //TODO create a stateful color object in the create conversation method that changes depending on the isBotThinking bool
                  );
                },
              )
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: createMessage,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


//------------------------------------------------------------------------------
//Hive Code




//------------------------------------------------------------------------------
//Firebase Code
//TODO create ListTile method that uses the _newMessageTextField TextEditingController as a controller
/*
class Firebase extends StatefulWidget {
  //@override
  //_FirebaseState createState() => _FirebaseState();
}
class _FirebaseState extends State<Firebase> {
  final TextEditingController _newMessageTextField = TextEditingController();

  final CollectionReference messageCollectionDB = FirebaseFirestore.instance.collection('MESSAGES');

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
          buildRow(context),
            SizedBox(height: 40,),
            ListItemsWidget(messageCollectionDB),
          ],
        ),
      ),
    );
  }

Expanded ListItemsWidget(messageCollectionDB) {
    return Expanded(
              child: StreamBuilder(
                stream: messageCollectionDB.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int position) {
                      return Card(
                          child: listTileWidget(snapshot, position),
                      );
                    }
                  );
                }
              )
            );
  }

  ListTile listTileWidget(AsyncSnapshot<QuerySnapshot> snapshot, int position) {
    return ListTile(
      leading: Icon(Icons.check_box),
      title: Text(snapshot.data!.docs[position]['message']),
      onTap: () {
        setState(() {
          _newMessageTextField.text = snapshot.data!.docs[position]['message'];
        });
      },
    );
  }

}

 */