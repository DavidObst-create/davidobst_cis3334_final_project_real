import 'package:flutter/material.dart';

void main() {
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



  void _incrementCounter() {
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
