class Pet {
  final int id;
  final String name;
  final int age;
  final String breed;
  final String size;
  final String description;
  final String location;
  final String adoptionStatus;
  final int userId;
  final String latitude;
  final String longitude;
  final List<String> images;
    final User user;


  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.breed,
    required this.size,
    required this.description,
    required this.location,
    required this.adoptionStatus,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.user,

  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      breed: json['breed'],
      size: json['size'],
      description: json['description'],
      location: json['location'],
      adoptionStatus: json['adoption_status'],
      userId: json['user_id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      images: List<String>.from(json['images'].map((img) => img['image_url'])),
            user: User.fromJson(json['user']),

    );
  }
}
class User {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] != null ? DateTime.parse(json['email_verified_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

