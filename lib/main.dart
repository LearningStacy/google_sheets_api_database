import 'package:flutter/material.dart';

Future main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Search in Database';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
