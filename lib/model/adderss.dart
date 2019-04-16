import 'package:meta/meta.dart';

class Address {
  final String address;
  final String city;
  final String state;
  final String zip;

  Address({
    @required this.address,
    @required this.city,
    @required this.state,
    @required this.zip,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
    };
  }

  static Address fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zip: map['zip'],
    );
  }
}
