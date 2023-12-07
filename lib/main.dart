import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<String> messages = <String>[];
bool isBotThinking = false;



  void createMessage() {
    setState(() {
      messages.add("Hello, I am a chatbot. How can I help you?");
      if (isBotThinking == false) {
        messages.add("bool is " + isBotThinking.toString());
        isBotThinking = true;
      }
      else {
        messages.add("bool is " + isBotThinking.toString());
        isBotThinking = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Container(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int position) {
            return ListTile(
              title: Text(messages[position]),
              tileColor: Colors.green,
            );
          },
        )
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: createMessage,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


//------------------------------------------------------------------------------
//Firebase Code
//TODO create ListTile method that uses the _newMessageTextField TextEditingController as a controller

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