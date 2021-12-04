class CoWorker {
  final String lastName;
  final String firstName;
  final String id;

  CoWorker(this.lastName, this.firstName, this.id);

  factory CoWorker.fromJson(Map<String, dynamic> json) {
    return CoWorker(json['lastName'], json['firstName'], json['id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'lastName': lastName,
        'firstName': firstName,
      };

  @override
  bool operator ==(Object other) => other is CoWorker && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
