import 'package:where_my_coworkers/stores/coworker_storage.dart';
import 'package:flutter/material.dart';

class CoWorkerFormPage extends StatefulWidget {
  CoWorkerFormPage({Key? key}) : super(key: key);

  final CoWorkerStorage storage = CoWorkerStorage();

  @override
  State<CoWorkerFormPage> createState() => _CoWorkerFormPageState();
}

class _CoWorkerFormPageState extends State<CoWorkerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final lastNameCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();

  void _create() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .writeCoWorker(lastNameCtrl.value.text.trim(), firstNameCtrl.value.text.trim())
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
        title: const Text('New co-worker'),
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
                  onPressed: _create,
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
