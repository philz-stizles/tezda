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
