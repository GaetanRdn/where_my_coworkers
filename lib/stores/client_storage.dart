import 'package:easymakers_tracker/models/client.dart';
import 'package:localstore/localstore.dart';


class ClientStorage {
  final Localstore _db = Localstore.instance;

  Future<void> write(String name, double latitude, double longitude) async {
    final id = _db.collection('clients').doc().id;
    _db
        .collection('clients')
        .doc(id)
        .set(Client(name, latitude, longitude, id).toJson());
    return Future.value();
  }

  Future<List<Client>> getAll() {
    return _db.collection('clients').get().then((value) {
      if (value != null) {
        List<Client> clients = value.entries.map((e) => Client.fromJson(e.value)).toList();
        return Future.value(clients);
      }
      return Future.value([]);
    });
  }
}
