import 'package:easymakers_tracker/models/easymaker.dart';
import 'package:easymakers_tracker/ui/forms/easymaker_form.dart';
import '../../stores/easymaker_storage.dart';
import 'package:easymakers_tracker/stores/mission_storage.dart';
import 'package:flutter/material.dart';

class EasymakersPage extends StatefulWidget {
  const EasymakersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EasymakersPage();
}

class _EasymakersPage extends State<EasymakersPage> {
  final EasymakerStorage _storage = EasymakerStorage();
  final MissionStorage _missionStorage = MissionStorage();
  Future<List<Easymaker>> _easymakers = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadEasymakers();
  }

  void loadEasymakers() {
    setState(() {
      _easymakers = _storage.getAll();
    });
  }

  Future<void> _askForConfirmation(Easymaker easymaker) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please, confirm that'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('So ' + easymaker.firstName + ' leaves us?'),
                const Text('This will also remove all his missions!'),
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
                _missionStorage.removeByEasymakerId(easymaker.id);
                _storage.remove(easymaker.id).then((value) => loadEasymakers());
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

  List<DataRow> getRows(List<Easymaker> easymakers) {
    return easymakers.map((e) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(e.firstName)),
          DataCell(Text(e.lastName)),
          DataCell(IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _askForConfirmation(e);
            },
          ))
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
                  future: _easymakers,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Easymaker>> snapshot) {
                    return DataTable(columns: const <DataColumn>[
                      DataColumn(label: Text('First name')),
                      DataColumn(label: Text('Last name')),
                      DataColumn(label: Text(''))
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
                              builder: (context) => EasymakerFormPage()),
                        ).then((value) => loadEasymakers());
                      },
                      child: const Icon(Icons.add)))),
        ],
      )
    ]);
  }
}
