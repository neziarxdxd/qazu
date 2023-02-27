class AccountModel {
  // ID, First Name, Last Name, Email, Password, Type
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? type;

  // All the fields are required
  AccountModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.type});

  // Convert the AccountModel object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'type': type,
    };
  }

  // Convert the Map object to an AccountModel object
  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      type: map['type'],
    );
  }

  // Convert the JSON object to an AccountModel object
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      type: json['type'],
    );
  }

  // Convert the AccountModel object to a JSON object
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'type': type,
      };
}
