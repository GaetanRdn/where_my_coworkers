import 'package:where_my_coworkers/models/mission.dart';
import 'package:localstore/localstore.dart';

class MissionStorage {
  final Localstore _db = Localstore.instance;

  Future<void> write(String coWorkerId, String clientId) async {
    final id = _db.collection('missions').doc().id;
    _db
        .collection('missions')
        .doc(id)
        .set(Mission(coWorkerId, clientId, id).toJson());
    return Future.value();
  }

  Future<List<Mission>> getAll() {
    return _db.collection('missions').get().then((value) {
      if (value != null) {
        List<Mission> missions =
            value.entries.map((e) => Mission.fromJson(e.value)).toList();
        return Future.value(missions);
      }
      return Future.value([]);
    });
  }

  Future remove(String id) {
    return _db.collection('missions').doc(id).delete();
  }

  Future removeByCoWorkerId(String id) {
    return getAll().then((List<Mission> missions) {
      missions.where((mission) => mission.coWorkerId == id).forEach((mission) {
        _db.collection('missions').doc(mission.id).delete();
      });
    });
  }
}
