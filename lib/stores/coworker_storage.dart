import 'dart:async';

import 'package:where_my_coworkers/models/coworker.dart';
import 'package:localstore/localstore.dart';

class CoWorkerStorage {
  final Localstore _db = Localstore.instance;

  Future<void> writeCoWorker(String lastName, String firstName) async {
    final id = _db.collection('coworkers').doc().id;
    _db.collection('coworkers').doc(id).set(CoWorker(lastName, firstName, id).toJson());
    return Future.value();
  }

  Future<List<CoWorker>> getAll() {
    return _db.collection('coworkers').get().then((value) {
      if (value != null) {
        List<CoWorker> coWorkers = value.entries.map((e) => CoWorker.fromJson(e.value)).toList();
        return Future.value(coWorkers);
      }
      return Future.value(<CoWorker>[]);
    });
  }

  Future remove(String id) {
    return _db.collection('coworkers').doc(id).delete();
  }
}
