import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/stores/client_storage.dart';
import 'package:where_my_coworkers/ui/cards/client_card.dart';
import 'package:where_my_coworkers/ui/forms/client_form.dart';
import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ClientsPageState();
}

class ClientsPageState extends State<ClientsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FutureBuilder(
            future: _clients,
            builder:
                (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
              return ListView(
                children: (snapshot.data ?? <Client>[]).map((client) {
                  return ClientCard(client: client);
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
                            builder: (context) => ClientFormPage()),
                      ).then((value) => loadClients());
                    },
                    child: const Icon(Icons.add)))),
      ],
    );
  }
}
