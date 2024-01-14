class User {
  User(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.avatar,
      this.address});
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final String? avatar;
  final Address? address;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        phone: json['phone'],
        avatar: json['avatar'],
        address: Address.fromJson(json['address']));
  }
}

class Address {
  Address({this.city, this.street, this.number, this.zipCode, this.location});
  final String? city;
  final String? street;
  final String? number;
  final String? zipCode;
  final GeoLocation? location;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipCode: json['zipCode'],
      location: json['location'] != null
          ? GeoLocation.fromJson(json['location'])
          : null,
    );
  }
}

class GeoLocation {
  GeoLocation({required this.lat, required this.long});
  final String lat;
  final String long;

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'] as String,
      long: json['long'] as String,
    );
  }
}
