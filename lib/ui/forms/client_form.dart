
import 'package:where_my_coworkers/models/client.dart';

import '../../stores/client_storage.dart';
import 'package:flutter/material.dart';

class ClientFormPage extends StatefulWidget {
  ClientFormPage({Key? key, this.client}) : super(key: key);

  final ClientStorage storage = ClientStorage();
  final Client? client;

  @override
  State<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends State<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final latitudeCtrl = TextEditingController();
  final longitudeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.client?.name ?? '';
    latitudeCtrl.text = widget.client?.latitude.toString() ?? '';
    longitudeCtrl.text = widget.client?.longitude.toString() ?? '';
  }

  void _create() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .create(nameCtrl.value.text.trim(), double.parse(latitudeCtrl.value.text.trim()),
          double.parse(longitudeCtrl.value.text.trim()))
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

  void _update() {
    if (_formKey.currentState!.validate()) {
      widget.storage
          .update(Client(nameCtrl.value.text.trim(), double.parse(latitudeCtrl.value.text.trim()),
          double.parse(longitudeCtrl.value.text.trim()), widget.client!.id))
          .whenComplete(() {
        var snackBar = SnackBar(
          content: (widget.client == null) ? const Text('Created!') : const Text('Saved!'),
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
        title: (widget.client == null) ? const Text('New Client') : const Text('Update Client'),
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
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    autofocus: true,
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name *'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    controller: latitudeCtrl,
                    decoration: const InputDecoration(labelText: 'Latitude *'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    controller: longitudeCtrl,
                    decoration: const InputDecoration(labelText: 'Longitude *'),
                  ),
                  const SizedBox(height: 20),
                  FloatingActionButton(
                    onPressed: (widget.client == null) ? _create : _update,
                    child: (widget.client == null) ? const Icon(Icons.add) : const Icon(Icons.save),
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
