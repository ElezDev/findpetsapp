// class Pets {
//   final int id;
//   final String name;
//   final double latitude;
//   final double longitude;
//   final String? imageUrl; // Agregar este campo


//   Pets({
//     required this.id,
//     required this.name,
//     required this.latitude,
//     required this.longitude,
//     this.imageUrl,
//   });
// }


class Pets {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final List<ImageModel> images; // Este es el nuevo campo requerido
  final String? imageUrl;

  Pets({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.images,
    this.imageUrl,
  });
}

class ImageModel {
  final int id;
  final int petId;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.petId,
    required this.imageUrl,
  });
}
