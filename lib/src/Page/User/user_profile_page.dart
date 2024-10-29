import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();

  final String profileImageUrl = 'assets/images/usuario2.png';
  final String userBio = 'Lover of pets and nature. Always ready to help!';

  final List<Pet> pets = [
    Pet('Dog', 'Golden Retriever', 'assets/images/perro2.png'),
    Pet('Cat', 'Persian', 'assets/images/perro.png'),
    Pet('Rabbit', 'Holland Lop', 'assets/images/perros1.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildUserInfo(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 20),
            const SizedBox(height: 8),
            _buildTiltle(context),
            _buildPetCarousel(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Positioned(
          top: 100,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImageUrl),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          authService.userData['name'] ?? 'Nombre de Usuario',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          authService.userData['email'] ?? 'Email',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            userBio,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTiltle(context) {
    return Text(
      'Mis Post',
      style: bigTitle(context),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Edit Profile', Icons.edit),
        _buildButton('Settings', Icons.settings),
      ],
    );
  }

  Widget _buildButton(String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // Lógica para cada botón
      },
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildPetCarousel() {
    return Container(
      height: 200, // Altura del carrusel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return _buildPetCard(pets[index]);
        },
      ),
    );
  }

  Widget _buildPetCard(Pet pet) {
    return Container(
      width: 170, // Ancho de cada tarjeta
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                pet.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                pet.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              pet.breed,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// Modelo de Mascota
class Pet {
  final String name;
  final String breed;
  final String imageUrl;

  Pet(this.name, this.breed, this.imageUrl);
}
