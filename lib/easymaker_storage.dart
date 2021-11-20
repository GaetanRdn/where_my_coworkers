import 'dart:convert';
import 'dart:html';

import 'package:easymakers_tracker/easymaker.dart';

class EasymakerStorage {
  final Storage _localStorage = window.localStorage;
  static var id = 1;

  Future<void> writeEasymaker(String lastName, String firstName) async {
    _localStorage.putIfAbsent('easymakers', () => '[]');
    MapEntry<String, String> entry = _localStorage.entries.singleWhere((element) => element.key == 'easymakers');
    Easymakers easymakers = Easymakers.fromJson(jsonDecode(entry.value));
    easymakers.easymakers.add(Easymaker(id++, lastName, firstName));
    _localStorage.update(entry.key, (value) => jsonEncode(easymakers.toJson()));
    return Future.value();
  }
}
