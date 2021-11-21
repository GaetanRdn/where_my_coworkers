import 'dart:async';

import 'package:easymakers_tracker/easymaker.dart';
import 'package:localstore/localstore.dart';

class EasymakerStorage {
  final Localstore _db = Localstore.instance;

  Future<void> writeEasymaker(String lastName, String firstName) async {
    final id = _db.collection('easymakers').doc().id;
    _db.collection('easymakers').doc(id).set(Easymaker(lastName, firstName, id).toJson());
    return Future.value();
  }

  Future<List<Easymaker>> getStream() {
    return _db.collection('easymakers').get().then((value) {
      if (value != null) {
        List<Easymaker> easymakers = value.entries.map((e) => Easymaker.fromJson(e.value)).toList();
        return Future.value(easymakers);
      }
      return Future.value(<Easymaker>[]);
    });
  }
}
