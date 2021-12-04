import 'package:where_my_coworkers/models/client.dart';
import 'package:where_my_coworkers/models/coworker.dart';

class Mission {
  final String coWorkerId;
  final String clientId;
  final String id;
  CoWorker? coWorker;
  Client? client;

  Mission(this.coWorkerId, this.clientId, this.id);

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(json['coWorkerId'], json['clientId'], json['id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'coWorkerId': coWorkerId,
        'clientId': clientId,
      };
}
