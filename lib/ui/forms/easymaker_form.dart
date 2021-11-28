import 'package:easymakers_tracker/stores/easymaker_storage.dart';
import 'package:flutter/material.dart';

class EasymakerFormPage extends StatefulWidget {
  EasymakerFormPage({Key? key}) : super(key: key);

  final EasymakerStorage storage = EasymakerStorage();

  @override
  State<EasymakerFormPage> createState() => _EasymakerFormPageState();
}

class _EasymakerFormPageState extends State<EasymakerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final lastNameCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();

  void _createEasymaker() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .writeEasymaker(lastNameCtrl.value.text, firstNameCtrl.value.text)
          .whenComplete(() {
        const snackBar = SnackBar(
          content: Text('Created!'),
          backgroundColor: Colors.green,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      });
    }
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
                TextFormField(
                  autofocus: true,
                  controller: firstNameCtrl,
                  decoration: const InputDecoration(labelText: 'First name *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: lastNameCtrl,
                  decoration: const InputDecoration(labelText: 'Last name *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
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
