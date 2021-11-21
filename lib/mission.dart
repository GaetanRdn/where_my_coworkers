class Mission {
  final String easymakerId;
  final String clientId;
  final String id;

  Mission(this.easymakerId, this.clientId, this.id);

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(json['id'], json['easymakerId'], json['clientId']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'easymakerId': easymakerId,
        'clientId': clientId,
      };
}
