
import 'package:easymakers_tracker/client_storage.dart';
import 'package:flutter/material.dart';

class ClientFormPage extends StatefulWidget {
  ClientFormPage({Key? key}) : super(key: key);

  final ClientStorage storage = ClientStorage();

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final latitudeCtrl = TextEditingController();
  final longitudeCtrl = TextEditingController();

  Future<void> _create() {
    return widget.storage
        .write(nameCtrl.value.text, double.parse(latitudeCtrl.value.text), double.parse(longitudeCtrl.value.text))
        .whenComplete(() {
      const snackBar = SnackBar(
        content: Text('Created!'),
        backgroundColor: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context);
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
                    controller: latitudeCtrl,
                    decoration: const InputDecoration(labelText: 'Latitude'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: longitudeCtrl,
                    decoration: const InputDecoration(labelText: 'Longitude'),
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
