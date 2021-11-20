import 'package:easymakers_tracker/client_storage.dart';
import 'package:flutter/material.dart';

class ClientFormPage extends StatefulWidget {
  const ClientFormPage({Key? key, required this.storage}) : super(key: key);

  final ClientStorage storage;

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final streetCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final zipCodeCtrl = TextEditingController();
  final countryCtrl = TextEditingController();

  Future<void> _create() {
    return widget.storage
        .write(nameCtrl.value.text, streetCtrl.value.text, cityCtrl.value.text,
            zipCodeCtrl.value.text, countryCtrl.value.text)
        .whenComplete(() {
      const snackBar = SnackBar(
        content: Text('Created!'),
        backgroundColor: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Client'),
      ),
      body: Center(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: streetCtrl,
                    decoration: const InputDecoration(labelText: 'Street'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: cityCtrl,
                    decoration: const InputDecoration(labelText: 'City'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: zipCodeCtrl,
                    decoration: const InputDecoration(labelText: 'Zip Code'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: countryCtrl,
                    decoration: const InputDecoration(labelText: 'Country'),
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
          )
        ],
      )),
    );
  }
}
