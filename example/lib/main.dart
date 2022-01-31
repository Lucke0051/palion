import 'package:flutter/material.dart';
import 'package:palion/widgets/sidebar/responsive_scaffold.dart';
import 'package:palion/widgets/sidebar/sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      tabs: [
        SidebarTab(key: "chaptera", title: "titlea"),
      ],
      title: const Text("hello"),
      body: const Center(
        child: Text("ok"),
      ),
    );
  }
}
