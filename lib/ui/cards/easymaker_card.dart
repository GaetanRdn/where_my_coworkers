import 'package:easymakers_tracker/models/easymaker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EasymakerCard extends StatelessWidget {
  const EasymakerCard({Key? key, required this.easymaker, required this.onRemove}) : super(key: key);

  final Easymaker easymaker;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: const CircleAvatar(
            child: Icon(Icons.account_circle)),
        title: Text(
            easymaker.firstName + ' ' + easymaker.lastName),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
