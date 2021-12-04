import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/stores/client_storage.dart';
import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/stores/coworker_storage.dart';
import 'package:where_my_coworkers/models/mission.dart';
import 'package:where_my_coworkers/ui/cards/mission_card.dart';
import 'package:where_my_coworkers/ui/forms/mission_form.dart';
import 'package:where_my_coworkers/stores/mission_storage.dart';
import 'package:flutter/material.dart';

class MissionsPage extends StatefulWidget {
  const MissionsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MissionsPage();
}

class _MissionsPage extends State<MissionsPage> {
  final CoWorkerStorage _coWorkerStorage = CoWorkerStorage();
  final MissionStorage _missionStorage = MissionStorage();
  final ClientStorage _clientStorage = ClientStorage();
  Future<List<Mission>> _missions = Future.value([]);

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    List<CoWorker> coWorkers = await _coWorkerStorage.getAll();
    List<Mission> missions = await _missionStorage.getAll();
    List<Client> clients = await _clientStorage.getAll();

    setState(() {
      _missions = Future.value(missions.map((mission) {
        mission.coWorker = coWorkers
            .where((coWorker) => coWorker.id == mission.coWorkerId)
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
                Text('So ' + mission.coWorker!.firstName + ' leaves ' + mission.client!.name + '?'),
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
          DataCell(Text(mission.coWorker!.firstName + ' - ' + mission.coWorker!.lastName)),
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
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: FutureBuilder(
                  future: _missions,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Mission>> snapshot) {
                    return ListView(
                      children: (snapshot.data ?? <Mission>[]).map((mission) {
                        return MissionCard(mission: mission, onRemove: () => _askForConfirmation(mission));
                      }).toList(),
                    );
                  },
              ),
          ),
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
    ;
  }
}
