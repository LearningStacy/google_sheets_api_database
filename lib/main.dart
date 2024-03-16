import 'package:flutter/material.dart';
import 'package:search_database_sheets_api/models/sheets_api_alphabet.dart';
import 'package:search_database_sheets_api/pages/MainPage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AlphabetSheetsAPI.init();

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
      home: MainPage(),
    );
  }
}
