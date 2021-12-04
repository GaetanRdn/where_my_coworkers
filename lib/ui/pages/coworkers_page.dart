import 'package:where_my_coworkers/models/coworker.dart';
import 'package:where_my_coworkers/stores/coworker_storage.dart';
import 'package:where_my_coworkers/stores/mission_storage.dart';
import 'package:where_my_coworkers/ui/cards/coworker_card.dart';
import 'package:where_my_coworkers/ui/forms/coworker_form.dart';
import 'package:flutter/material.dart';

class CoWorkersPage extends StatefulWidget {
  const CoWorkersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CoWorkersPageState();
}

class CoWorkersPageState extends State<CoWorkersPage> {
  final CoWorkerStorage _storage = CoWorkerStorage();
  final MissionStorage _missionStorage = MissionStorage();
  Future<List<CoWorker>> _coWorkers = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadCoWorkers();
  }

  void loadCoWorkers() {
    setState(() {
      _coWorkers = _storage.getAll();
    });
  }

  Future<void> _askForConfirmation(CoWorker coWorker) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please, confirm that'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('So ' + coWorker.firstName + ' leaves us?'),
                const Text('This will also remove all his missions!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text('Confirm'),
              onPressed: () => remove(context, coWorker),
            ),
          ],
        );
      },
    );
  }

  void remove(BuildContext context, CoWorker coWorker) {
    _missionStorage.removeByCoWorkerId(coWorker.id);
    _storage.remove(coWorker.id).then((value) => loadCoWorkers());
    const snackBar = SnackBar(
      content: Text('Removed!'),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FutureBuilder(
            future: _coWorkers,
            initialData: const <CoWorker>[],
            builder: (BuildContext context,
                AsyncSnapshot<List<CoWorker>> snapshot) {
              return ListView(
                children: (snapshot.data ?? <CoWorker>[]).map((CoWorker coWorker) {
                  return CoWorkerCard(
                    coWorker: coWorker,
                    onRemove: () => _askForConfirmation(coWorker),
                  );
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
                            builder: (context) => CoWorkerFormPage()),
                      ).then((value) => loadCoWorkers());
                    },
                    child: const Icon(Icons.add)))),
      ],
    );
  }
}
