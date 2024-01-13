class User {
  User(
      {this.id,
      required this.name,
      required this.email,
      this.phone,
      this.avatar,
      this.address});
  final String? id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final Address? address;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String,
    );
  }
}

class Address {
  Address(
      {this.id,
      required this.name,
      required this.email,
      this.avatar,
      this.location});
  final String? id;
  final String name;
  final String email;
  final String? avatar;
  final GeoLocation? location;
}

class GeoLocation {
  GeoLocation({required this.lat, required this.long});
  final String lat;
  final String long;
}
