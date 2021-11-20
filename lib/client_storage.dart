import 'package:easymakers_tracker/client.dart';
import 'package:localstore/localstore.dart';

class ClientStorage {
  final Localstore _db = Localstore.instance;

  Future<void> write(String name, String street, String city,
      String zipCode, String country) async {
    final id = _db.collection('clients').doc().id;
    _db
        .collection('clients')
        .doc(id)
        .set(Client(name, street, city, zipCode, country, id).toJson());
    return Future.value();
  }
}
