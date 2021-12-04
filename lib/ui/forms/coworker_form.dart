import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/stores/coworker_storage.dart';
import 'package:flutter/material.dart';

class CoWorkerFormPage extends StatefulWidget {
  CoWorkerFormPage({Key? key, this.coWorker}) : super(key: key);

  final CoWorkerStorage storage = CoWorkerStorage();
  final CoWorker? coWorker;

  @override
  State<CoWorkerFormPage> createState() => _CoWorkerFormPageState();
}

class _CoWorkerFormPageState extends State<CoWorkerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final lastNameCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    lastNameCtrl.text = widget.coWorker?.lastName ?? '';
    firstNameCtrl.text = widget.coWorker?.firstName ?? '';
  }

  void _create() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .writeCoWorker(lastNameCtrl.value.text.trim(), firstNameCtrl.value.text.trim())
          .whenComplete(() {
        var snackBar = SnackBar(
          content: (widget.coWorker == null) ? const Text('Created!') : const Text('Saved!'),
          backgroundColor: Colors.green,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pop(context);
      });
    }
  }

  void _update() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .update(CoWorker(lastNameCtrl.value.text.trim(), firstNameCtrl.value.text.trim(), widget.coWorker!.id))
          .whenComplete(() {
        var snackBar = SnackBar(
          content: (widget.coWorker == null) ? const Text('Created!') : const Text('Saved!'),
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
        title: (widget.coWorker == null) ? const Text('New co-worker') : const Text('Update co-worker'),
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
                FloatingActionButton(
                  onPressed: (widget.coWorker == null) ? _create : _update,
                  child: (widget.coWorker == null) ? const Icon(Icons.add) : const Icon(Icons.save),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
