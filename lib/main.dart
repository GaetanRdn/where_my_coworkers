
import 'package:easymakers_tracker/easymaker_form.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasymakerFormPage(storage: EasymakerStorage()),
    );
  }
}
