import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _apiKey = 'your api key';
  String _api =
      'your api url';

  late String _gelenCevap;

      Future<void> _incrementCounter() async {
        http.Response cevap = await http.get(Uri.parse(_api));
        if (cevap.statusCode == 200) {
          Map gelenJson= jsonDecode(cevap.body);
          _gelenCevap= gelenJson['coord']['lon'];
        } else {
          _gelenCevap = 'bağlantı sorunu';
        }
        setState(() {});
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          const Text(
            'Gelen Cevap:',
          ),
          Text(
            '$_gelenCevap',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
