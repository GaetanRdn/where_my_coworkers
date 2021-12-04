import 'package:where_my_coworkers/models/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_my_coworkers/ui/forms/client_form.dart';
import 'package:where_my_coworkers/ui/pages/clients_page.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientFormPage(client: client)),
          ).then((value) => context
              .findAncestorStateOfType<ClientsPageState>()
              ?.loadClients());
        },
        leading: const CircleAvatar(
            child: Icon(Icons.business)),
        title: Text(client.name),
      ),
    );
  }
}
