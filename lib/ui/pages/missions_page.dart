import 'package:easymakers_tracker/models/client.dart';
import 'package:easymakers_tracker/stores/client_storage.dart';
import 'package:easymakers_tracker/models/easymaker.dart';
import 'package:easymakers_tracker/stores/easymaker_storage.dart';
import 'package:easymakers_tracker/models/mission.dart';
import 'package:easymakers_tracker/ui/forms/mission_form.dart';
import 'package:easymakers_tracker/stores/mission_storage.dart';
import 'package:flutter/material.dart';

class MissionsPage extends StatefulWidget {
  const MissionsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MissionsPage();
}

class _MissionsPage extends State<MissionsPage> {
  final EasymakerStorage _easymakerStorage = EasymakerStorage();
  final MissionStorage _missionStorage = MissionStorage();
  final ClientStorage _clientStorage = ClientStorage();
  Future<List<Mission>> _missions = Future.value([]);

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    List<Easymaker> easymakers = await _easymakerStorage.getAll();
    List<Mission> missions = await _missionStorage.getAll();
    List<Client> clients = await _clientStorage.getAll();

    setState(() {
      _missions = Future.value(missions.map((mission) {
        mission.easymaker = easymakers
            .where((easymaker) => easymaker.id == mission.easymakerId)
            .first;

        mission.client = clients.where((client) => client.id == mission.clientId).first;

        return mission;
      }).toList());
    });
  }

  Future<void> _askForConfirmation(Mission mission) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please, confirm that'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('So ' + mission.easymaker!.firstName + ' leaves ' + mission.client!.name + '?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text('Confirm'),
              onPressed: () {
                _missionStorage.remove(mission.id).then((value) => load());
                const snackBar = SnackBar(
                  content: Text('Removed!'),
                  backgroundColor: Colors.green,
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<DataRow> getRows(List<Mission> missions) {
    return missions.map((mission) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(mission.easymaker!.firstName + ' - ' + mission.easymaker!.lastName)),
          DataCell(Text(mission.client!.name)),
          DataCell(IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _askForConfirmation(mission);
            },
          )),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                  future: _missions,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Mission>> snapshot) {
                    return DataTable(columns: const <DataColumn>[
                      DataColumn(label: Text('Easymaker')),
                      DataColumn(label: Text('Client')),
                      DataColumn(label: Text('')),
                    ], rows: getRows(snapshot.data ?? []));
                  })),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MissionFormPage()),
                        ).then((value) => load());
                      },
                      child: const Icon(Icons.add)))),
        ],
      )
    ]);
  }
}
