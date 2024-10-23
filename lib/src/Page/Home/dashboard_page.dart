import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/Services/auth_service.dart';

class DashboardPage extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

  DashboardPage({super.key});

  // Simulación de datos
  final List<Map<String, String>> featuredAnimals = [
    {
      'name': 'Perro Feliz',
      'image':
          'https://media.istockphoto.com/id/513133900/es/foto/oro-retriever-sentado-en-frente-de-un-fondo-blanco.jpg?s=612x612&w=0&k=20&c=0lRWImB8Y4p6X6YGt06c6q8I3AqBgKD-OGQxjLCI5EY=',
      'details': 'Edad: 2 años\nRaza: Labrador',
    }, 
    {
      'name': 'Gato Travieso',
      'image':
          'https://media.istockphoto.com/id/513133900/es/foto/oro-retriever-sentado-en-frente-de-un-fondo-blanco.jpg?s=612x612&w=0&k=20&c=0lRWImB8Y4p6X6YGt06c6q8I3AqBgKD-OGQxjLCI5EY=',
      'details': 'Edad: 1 año\nRaza: Siames',
    },
    // Más animales
  ];

  final List<String> breeds = [
    'Labrador',
    'Siames',
    'Bulldog',
    'Poodle',
    'Gato Persa'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección: Filtro de Razas
              Text('Filtrar por Raza', style: titleGeneral(context)),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: breeds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para filtrar animales por raza
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(breeds[index]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Sección: Adopciones de la Semana
              Text('Adopciones de la Semana', style: titleGeneral(context)),
              const SizedBox(height: 10),
              SizedBox(
                height: 300, // Altura fija para la sección
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredAnimals.length,
                  itemBuilder: (context, index) {
                    final animal = featuredAnimals[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
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
                              children: [
                                Text(
                                  animal['name']!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  animal['details']!,
                                  textAlign: TextAlign.center,
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
                                },
                                child: const Text('Me gusta'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Acción para "Compartir"
                                },
                                child: const Text('Compartir'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Sección: Noticias
              Text('Noticias Recientes', style: titleGeneral(context)),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  title: Text('Nueva campaña de adopción!'),
                  subtitle: Text(
                      '¡Adopta un amigo hoy! Visita nuestro sitio para más información.'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navegar a la página de noticias
                  },
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  title: Text('Consejos para el cuidado de mascotas'),
                  subtitle: Text(
                      'Aprende cómo cuidar mejor de tu nuevo amigo peludo.'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navegar a la página de consejos
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
