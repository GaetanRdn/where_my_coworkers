import 'package:easymakers_tracker/easymaker.dart';
import 'package:easymakers_tracker/easymaker_form.dart';
import 'package:easymakers_tracker/easymaker_storage.dart';
import 'package:flutter/material.dart';

class EasymakersPage extends StatefulWidget {
  const EasymakersPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EasymakersPage();
}

class _EasymakersPage extends State<EasymakersPage> {
  final EasymakerStorage storage = EasymakerStorage();
  Future<List<Easymaker>> _easymakers = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadEasymakers();
  }

  void loadEasymakers() {
    setState(() {
      _easymakers = storage.getAll();
    });
  }

  List<DataRow> getRows(List<Easymaker> easymakers) {
    return easymakers.map((e) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(e.firstName)),
          DataCell(Text(e.lastName)),
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
                      DataColumn(label: Text('Last name'))
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
