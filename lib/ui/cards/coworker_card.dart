import 'package:where_my_coworkers/models/coworker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoWorkerCard extends StatelessWidget {
  const CoWorkerCard({Key? key, required this.coWorker, required this.onRemove}) : super(key: key);

  final CoWorker coWorker;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const CircleAvatar(
            child: Icon(Icons.account_circle)),
        title: Text(
            coWorker.firstName + ' ' + coWorker.lastName),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
