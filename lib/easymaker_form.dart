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
        title: const Text('New Easymaker'),
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
                decoration: InputDecoration(labelText: 'First name'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(labelText: 'Last name'),
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
