class Client {
  final String name;
  final String street;
  final String city;
  final String zipCode;
  final String country;
  final String id;

  Client(this.name, this.street, this.city, this.zipCode, this.country,
      this.id);

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(json['id'], json['name'], json['street'], json['city'],
        json['zipCode'], json['country']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'street': street,
        'city': city,
        'zipCode': zipCode,
        'country': country,
      };
}
