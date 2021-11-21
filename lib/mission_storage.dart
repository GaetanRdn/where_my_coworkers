import 'package:easymakers_tracker/mission.dart';
import 'package:localstore/localstore.dart';

class MissionStorage {
  final Localstore _db = Localstore.instance;

  Future<void> write(String easymakerId, String clientId) async {
    final id = _db.collection('missions').doc().id;
    _db.collection('missions').doc(id).set(Mission(easymakerId, clientId, id).toJson());
    return Future.value();
  }
}
