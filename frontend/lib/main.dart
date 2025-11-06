import 'package:flutter/material.dart';
import 'package:frontend/HomeTab/Views/InOutStateView.dart';
void main() {
  runApp(const MyApp());
}

const BGC = Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랩실 출석부',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: BGC),
      ),
      home: const MyHomePage(title: '랩실 출석부'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BGC,
        title: Text(widget.title),
      ),
      body: ListView(
        children: const <Widget>[
          LabStatusCard(),
        ],
      ),
    );
  }
}
