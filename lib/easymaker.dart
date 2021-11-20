class Easymaker {
  final String lastName;
  final String firstName;
  int? id;

  Easymaker(this.lastName, this.firstName, [this.id]);

  factory Easymaker.fromJson(Map<String, dynamic> json) {
    return Easymaker(json['id'], json['lastName'], json['firstName']);
  }

  Map<String, dynamic> toJson() => {
        'lastName': lastName,
        'firstName': firstName,
      };
}

class Easymakers {
  final List<Easymaker> easymakers;

  Easymakers({required this.easymakers});

  factory Easymakers.fromJson(List<dynamic> json) {
    List<Easymaker> entireList = <Easymaker>[];

    entireList = json.map((dynamic i) => Easymaker.fromJson(i)).toList();

    return Easymakers(
      easymakers: entireList,
    );
  }

  toJson() {
    return easymakers.map((Easymaker easymaker) => easymaker.toJson()).toList();
  }
}
