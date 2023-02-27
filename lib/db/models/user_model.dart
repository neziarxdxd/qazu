import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  // contains ID, email, first name, last name, password, type
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? password;
  @HiveField(5)
  String? type;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.type});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      type: map['type'],
    );
  }

  //to string
  @override
  String toString() {
    return 'UserModel{id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, type: $type}';
  }
}
