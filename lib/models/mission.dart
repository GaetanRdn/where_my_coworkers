import 'package:easymakers_tracker/models/client.dart';
import 'package:easymakers_tracker/models/easymaker.dart';

class Mission {
  final String easymakerId;
  final String clientId;
  final String id;
  Easymaker? easymaker;
  Client? client;

  Mission(this.easymakerId, this.clientId, this.id);

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(json['easymakerId'], json['clientId'], json['id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'easymakerId': easymakerId,
        'clientId': clientId,
      };
}
