import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Websockets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'WebSockets & Riverpod Demo'),
      },
    );
  }
}

final channel = WebSocketChannel.connect(
  Uri.parse('wss://echo.websocket.events'),
);

final streamProviderCounter = StreamProvider<dynamic>((ref) {
  return channel.stream;
});

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  final TextEditingController _controller = TextEditingController();

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _sendCounterToWebSockets() {
    channel.sink.add('$counter');
    //widget.channel.sink.close();
  }

  void _sendMessageToWebSockets() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
            ),
            const SizedBox(
              height: 100.0,
            ),
            const Text(
              'Or send a custom message to WebSockets:',
            ),
            Form(
              child: Container(
                width: 400,
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      labelText: 'Type your message here'),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: _sendMessageToWebSockets,
              child: const Text('Send Your Message!'),
            ),
            const SizedBox(
              height: 100.0,
            ),
            const Text('Riverpod returns:'),
            Consumer(
              builder: ((context, ref, child) {
                final value = ref.watch(streamProviderCounter).value;
                return Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
          _sendCounterToWebSockets();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
