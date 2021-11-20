import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:flutter/material.dart';

class EasymakerFormPage extends StatefulWidget {
  const EasymakerFormPage({Key? key, required this.storage}) : super(key: key);

  final EasymakerStorage storage;

  @override
  State<EasymakerFormPage> createState() => _EasymakerFormPageState();
}

class _EasymakerFormPageState extends State<EasymakerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final lastNameCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();

  Future<void> _createEasymaker() {
    return widget.storage
        .writeEasymaker(
            lastNameCtrl.value.text, firstNameCtrl.value.text)
        .whenComplete(() {
      const snackBar = SnackBar(content: Text('Created!'), backgroundColor: Colors.green,);

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Easymaker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: firstNameCtrl,
                  decoration: const InputDecoration(labelText: 'First name'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: lastNameCtrl,
                  decoration: const InputDecoration(labelText: 'Last name'),
                ),
                const SizedBox(height: 20),
                FloatingActionButton.extended(
                  onPressed: _createEasymaker,
                  label: const Text('Create'),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
