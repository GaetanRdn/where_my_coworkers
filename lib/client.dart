class Client {
  final String name;
  final double latitude;
  final double longitude;
  final String id;

  Client(this.name, this.latitude, this.longitude, this.id);

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        json['name'], json['latitude'], json['longitude'], json['id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  bool operator ==(Object other) => other is Client && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
