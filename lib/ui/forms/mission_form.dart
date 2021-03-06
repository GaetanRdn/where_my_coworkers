import 'dart:async';

import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/stores/client_storage.dart';
import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/stores/coworker_storage.dart';
import 'package:where_my_coworkers/stores/mission_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MissionFormPage extends StatefulWidget {
  MissionFormPage({Key? key}) : super(key: key);

  final MissionStorage missionStorage = MissionStorage();
  final CoWorkerStorage coworkerStorage = CoWorkerStorage();
  final ClientStorage clientStorage = ClientStorage();

  @override
  State<MissionFormPage> createState() => _MissionFormPageState();
}

class _MissionFormPageState extends State<MissionFormPage> {
  final _formKey = GlobalKey<FormState>();
  CoWorker? coWorker;
  Client? client;

  Future<List<CoWorker>> loadCoWorkers() {
    return widget.coworkerStorage.getAll();
  }

  Future<List<Client>> loadClients() {
    return widget.clientStorage.getAll();
  }

  void _create() {
    if (_formKey.currentState!.validate()) {
      widget.missionStorage.write(coWorker!.id, client!.id).whenComplete(() {
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
        title: const Text('New Mission'),
      ),
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FutureBuilder(
                      future: loadCoWorkers(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CoWorker>> snapshot) {
                        return coWorkerDropdown(context, snapshot);
                      }),
                  const SizedBox(height: 20),
                  FutureBuilder(
                      future: loadClients(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Client>> snapshot) {
                        return clientDropdown(context, snapshot);
                      }),
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
        ]),
      ),
    );
  }

  DropdownButtonFormField<CoWorker> coWorkerDropdown(
      BuildContext context, AsyncSnapshot<List<CoWorker>> snapshot) {
    List<DropdownMenuItem<CoWorker>> items = snapshot.data
            ?.map((e) => DropdownMenuItem<CoWorker>(
                  child: Text(e.firstName + ' - ' + e.lastName),
                  value: e,
                ))
            .toList() ??
        [];

    return DropdownButtonFormField<CoWorker>(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: coWorker,
        onChanged: (val) => setState(() => coWorker = val),
        decoration: const InputDecoration(labelText: 'Co-worker *'),
        items: items);
  }

  DropdownButtonFormField<Client> clientDropdown(
      BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
    List<DropdownMenuItem<Client>> items = snapshot.data
            ?.map((e) => DropdownMenuItem<Client>(
                  child: Text(e.name),
                  value: e,
                ))
            .toList() ??
        [];

    return DropdownButtonFormField<Client>(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: client,
        isExpanded: true,
        onChanged: (val) => setState(() => client = val),
        decoration: const InputDecoration(labelText: 'Client *'),
        items: items);
  }
}
