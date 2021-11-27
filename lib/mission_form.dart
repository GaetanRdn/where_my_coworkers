import 'dart:async';

import 'package:easymakers_tracker/client.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:easymakers_tracker/easymaker.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:easymakers_tracker/mission_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MissionFormPage extends StatefulWidget {
  MissionFormPage({Key? key}) : super(key: key);

  final MissionStorage missionStorage = MissionStorage();
  final EasymakerStorage easymakerStorage = EasymakerStorage();
  final ClientStorage clientStorage = ClientStorage();

  @override
  State<MissionFormPage> createState() => _MissionFormPageState();
}

class _MissionFormPageState extends State<MissionFormPage> {
  final _formKey = GlobalKey<FormState>();
  Easymaker? easymaker;
  Client? client;

  Future<List<Easymaker>> loadEasymakers() {
    return widget.easymakerStorage.getAll();
  }

  Future<List<Client>> loadClients() {
    return widget.clientStorage.getAll();
  }

  void _create() {
    if (_formKey.currentState!.validate()) {
      widget.missionStorage.write(easymaker!.id, client!.id).whenComplete(() {
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
                      future: loadEasymakers(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Easymaker>> snapshot) {
                        return easymakerDropdown(context, snapshot);
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

  DropdownButtonFormField<Easymaker> easymakerDropdown(
      BuildContext context, AsyncSnapshot<List<Easymaker>> snapshot) {
    List<DropdownMenuItem<Easymaker>> items = snapshot.data
            ?.map((e) => DropdownMenuItem<Easymaker>(
                  child: Text(e.firstName + ' - ' + e.lastName),
                  value: e,
                ))
            .toList() ??
        [];

    return DropdownButtonFormField<Easymaker>(
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        value: easymaker,
        onChanged: (val) => setState(() => easymaker = val),
        decoration: const InputDecoration(labelText: 'Easymaker *'),
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
