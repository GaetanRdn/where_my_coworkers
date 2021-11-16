import 'package:flutter/material.dart';

class EasymakerFormPage extends StatefulWidget {
  const EasymakerFormPage({Key? key}) : super(key: key);

  @override
  State<EasymakerFormPage> createState() => _EasymakerFormPageState();
}

class _EasymakerFormPageState extends State<EasymakerFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Easymaker form'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const TextField(
                autofocus: true,
                decoration: InputDecoration(label: Text('First name')),
              ),
              const SizedBox(height: 20),
              const TextField(
                autofocus: true,
                decoration: InputDecoration(label: Text('Last name')),
              ),
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('Create'),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
