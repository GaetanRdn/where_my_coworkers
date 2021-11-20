class Easymaker {
  final String lastName;
  final String firstName;
  final String id;

  Easymaker(this.lastName, this.firstName, this.id);

  factory Easymaker.fromJson(Map<String, dynamic> json) {
    return Easymaker(json['id'], json['lastName'], json['firstName']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'lastName': lastName,
        'firstName': firstName,
      };
}
