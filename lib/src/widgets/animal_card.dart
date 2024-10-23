import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final Map<String, String> animal;

  const AnimalCard({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              animal['image']!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  animal['name']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  animal['details']!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Acción para "Me gusta"
                  // Aquí puedes implementar la lógica para dar "Me gusta"
                },
                child: const Text('Me gusta'),
              ),
              TextButton(
                onPressed: () {
                  // Acción para "Compartir"
                  // Aquí puedes implementar la lógica para compartir
                },
                child: const Text('Compartir'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
