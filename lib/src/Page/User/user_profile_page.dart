import 'package:findpetapp/src/Page/PetsPost/controllers/pet_controller.dart';
import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:findpetapp/src/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:findpetapp/src/Services/auth_service.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final AuthService authService = Get.find<AuthService>();
  final PetController petController = Get.put(PetController());

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
            _buildMainActionButtons(),
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
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Positioned(
          top: 20,
          right: 5,
          child: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Editar Perfil') {}
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'Editar Perfil',
                child: Text('Editar Perfil'),
              ),
            ],
            icon: Image.asset(
              'assets/images/tres-puntos.png',
              width: 34,
              height: 34,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 9,
          child: CircleAvatar(
            radius: 90,
            backgroundImage: authService.userData['persona'] != null &&
                    authService.userData['persona'].isNotEmpty
                ? NetworkImage(authService.userData['persona'][0]['image_url'])
                : const AssetImage('assets/images/usuario2.png')
                    as ImageProvider,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          '${authService.userData['persona'][0]['first_name'] ?? ''} ${authService.userData['persona'][0]['last_name'] ?? ''}'
              .trim(),
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
            authService.userData['persona'][0]['biography'] ?? 'No Biography',
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

  Widget _buildMainActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton('Llamar', Icons.phone_callback_rounded,
            petController.makePhoneCall),
        _buildButton('Conectar', Icons.connect_without_contact, () {}),
      ],
    );
  }

  Widget _buildButton(String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
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
        return const Center(child: CircularProgressIndicator());
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
