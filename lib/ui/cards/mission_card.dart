import 'package:where_my_coworkers/models/mission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({Key? key, required this.mission, required this.onRemove})
      : super(key: key);

  final Mission mission;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.military_tech)),
        title: Text((mission.coWorker?.firstName ?? '') +
            ' ' +
            (mission.coWorker?.lastName ?? '')),
        subtitle: Text(mission.client?.name ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
