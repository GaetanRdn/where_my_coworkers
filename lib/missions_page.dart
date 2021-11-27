import 'package:easymakers_tracker/client.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:easymakers_tracker/easymaker.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:easymakers_tracker/mission.dart';
import 'package:easymakers_tracker/mission_form.dart';
import 'package:easymakers_tracker/mission_storage.dart';
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
  Future<List<Map<String, Object>>> _missions = Future.value([]);

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
        return { "easymaker": easymakers.where((easymaker) => easymaker.id == mission.easymakerId).first, "client": clients.where((client) => client.id == mission.clientId).first };
      }).toList());
    });
  }

  List<DataRow> getRows(List<Map<String, Object>> missions) {
    return missions.map((mission) {
      Easymaker easymaker = mission["easymaker"] as Easymaker;
      Client client = mission["client"] as Client;

      return DataRow(
        cells: <DataCell>[
          DataCell(Text(easymaker.firstName + ' - ' + easymaker.lastName)),
          DataCell(Text(client.name)),
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
                      AsyncSnapshot<List<Map<String, Object>>> snapshot) {
                    return DataTable(columns: const <DataColumn>[
                      DataColumn(label: Text('Easymaker')),
                      DataColumn(label: Text('Client'))
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
