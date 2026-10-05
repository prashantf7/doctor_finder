class AppUser {
  final String email;
  final String name;
  final String phoneNumber;
  final String imageUrl;
  final String location;
  final double latitude;
  final double longitude;
  final String userId;
  final String type;

  const AppUser({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.type,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      phoneNumber: map['phoneNumber'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      location: map['location'] as String? ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      userId: map['userId'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'AppUser{'
        'email: $email, '
        'name: $name, '
        'phoneNumber: $phoneNumber, '
        'imageUrl: $imageUrl, '
        'location: $location, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'userId: $userId, '
        'type: $type'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          name == other.name &&
          phoneNumber == other.phoneNumber &&
          imageUrl == other.imageUrl &&
          location == other.location &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          userId == other.userId &&
          type == other.type;

  @override
  int get hashCode =>
      email.hashCode ^
      name.hashCode ^
      phoneNumber.hashCode ^
      imageUrl.hashCode ^
      location.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      userId.hashCode ^
      type.hashCode;
}
