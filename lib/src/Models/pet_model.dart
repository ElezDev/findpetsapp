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
  });

  // Método para convertir JSON a Pet
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
    );
  }
}
