import 'package:findpetapp/src/Page/PetsPost/controllers/pet_controller.dart';
import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:findpetapp/src/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();
  final PetController petController = Get.put(PetController());

  final String profileImageUrl = 'assets/images/usuario2.png';
  final String userBio = 'Lover of pets and nature. Always ready to help!';

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
          decoration: const BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Positioned(
          top: 90,
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
        _buildButton('Editar Perfil', Icons.edit),
        _buildButton('Llamar', Icons.phone_callback_rounded),
      ],
    );
  }

  Widget _buildButton(String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildPetCarousel() {
    return Obx(() {
      if (petController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: petController.petsUser.length,
          itemBuilder: (context, index) {
            return _buildPetCard(petController.petsUser[index]);
          },
        ),
      );
    });
  }

  Widget _buildPetCard(Pet pet) {
    return Container(
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                pet.images[0],
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
