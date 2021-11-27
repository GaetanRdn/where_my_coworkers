import 'package:easymakers_tracker/client.dart';
import 'package:easymakers_tracker/client_form.dart';
import 'package:easymakers_tracker/client_storage.dart';
import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EasymakersPage();
}

class _EasymakersPage extends State<ClientsPage> {
  final ClientStorage storage = ClientStorage();
  Future<List<Client>> _clients = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  void loadClients() {
    setState(() {
      _clients = storage.getAll();
    });
  }

  List<DataRow> getRows(List<Client> clients) {
    return clients.map((e) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.latitude.toString())),
          DataCell(Text(e.longitude.toString())),
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
                  future: _clients,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Client>> snapshot) {
                    return DataTable(columns: const <DataColumn>[
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Latitude')),
                      DataColumn(label: Text('Longitude'))
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
                              builder: (context) => ClientFormPage()),
                        ).then((value) => loadClients());
                      },
                      child: const Icon(Icons.add)))),
        ],
      )
    ]);
  }
}
