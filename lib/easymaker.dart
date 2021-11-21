class Easymaker {
  final String lastName;
  final String firstName;
  final String id;

  Easymaker(this.lastName, this.firstName, this.id);

  factory Easymaker.fromJson(Map<String, dynamic> json) {
    return Easymaker(json['lastName'], json['firstName'], json['id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'lastName': lastName,
        'firstName': firstName,
      };

  @override
  bool operator ==(Object other) => other is Easymaker && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
