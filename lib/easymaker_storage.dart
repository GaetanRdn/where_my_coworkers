import 'package:easymakers_tracker/easymaker.dart';
import 'package:localstore/localstore.dart';

class EasymakerStorage {
  final Localstore _db = Localstore.instance;

  Future<void> writeEasymaker(String lastName, String firstName) async {
    final id = _db.collection('easymakers').doc().id;
    _db.collection('easymakers').doc(id).set(Easymaker(lastName, firstName, id).toJson());
    return Future.value();
  }
}
