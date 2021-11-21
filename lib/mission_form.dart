import 'dart:async';

import 'package:easymakers_tracker/client.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:easymakers_tracker/easymaker.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:easymakers_tracker/mission_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MissionFormPage extends StatefulWidget {
  const MissionFormPage(
      {Key? key,
      required this.missionStorage,
      required this.clientStorage,
      required this.easymakerStorage})
      : super(key: key);

  final MissionStorage missionStorage;
  final EasymakerStorage easymakerStorage;
  final ClientStorage clientStorage;

  @override
  State<MissionFormPage> createState() => _MissionFormPageState();
}

class _MissionFormPageState extends State<MissionFormPage> {
  final _formKey = GlobalKey<FormState>();
  Easymaker? easymaker;
  Client? client;

  Future<List<Easymaker>> loadEasymakers() async {
      return await widget.easymakerStorage.getStream();
  }

  Future<List<Client>> loadClients() async {
    return await widget.clientStorage.getStream();
  }

  Future<void> _create() {
    if (easymaker != null && client != null) {
      return widget.missionStorage
          .write(easymaker!.id, client!.id)
          .whenComplete(() {
        const snackBar = SnackBar(
          content: Text('Created!'), backgroundColor: Colors.green,);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Mission'),
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
                FutureBuilder(future: loadEasymakers(), builder: (BuildContext context, AsyncSnapshot<List<Easymaker>> snapshot) {
                  return easymakerDropdown(context, snapshot);
                }),
                const SizedBox(height: 20),
                FutureBuilder(future: loadClients(), builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
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

  DropdownButtonFormField<Easymaker> easymakerDropdown(BuildContext context, AsyncSnapshot<List<Easymaker>> snapshot) {
    List<DropdownMenuItem<Easymaker>> items = snapshot.data?.map((e) => DropdownMenuItem<Easymaker>(
      child: Text(e.firstName + ' - ' + e.lastName),
      value: e,
    ))
        .toList() ?? [];

    return DropdownButtonFormField<Easymaker>(
      value: easymaker,
      onChanged: (val) => setState(() => easymaker = val),
        decoration: const InputDecoration(label: Text('Easymaker')),
        items: items);
  }

  DropdownButtonFormField<Client> clientDropdown(BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
    List<DropdownMenuItem<Client>> items = snapshot.data?.map((e) => DropdownMenuItem<Client>(
      child: Text(e.name),
      value: e,
    ))
        .toList() ?? [];

    return DropdownButtonFormField<Client>(
      value: client,
        isExpanded: true,
        onChanged: (val) => setState(() => client = val),
        decoration: const InputDecoration(label: Text('Client')),
        items: items);
  }
}
