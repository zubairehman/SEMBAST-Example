import 'package:meta/meta.dart';
import 'package:sembast_tutorial/model/adderss.dart';

class User {

  // Id will be gotten from the database.
  // It's automatically generated & unique for every stored Fruit.
  int id;

  final String name;
  final String email;
  final String profilePic;
  final List<String> skills;
  final Address address;

  User({
    @required this.name,
    @required this.email,
    @required this.profilePic,
    @required this.skills,
    @required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'skills': List<dynamic>.from(skills.map((x) => x)),
      'address': address.toMap(),
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      profilePic: map['profilePic'],
      skills: List<String>.from(map["skills"].map((x) => x)),
      address: Address.fromMap(map['address']),
    );
  }
}
