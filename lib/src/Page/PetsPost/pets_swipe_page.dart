import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/models/pet_model.dart'; 
import 'package:findpetapp/src/Page/PetsPost/controllers/pet_controller.dart';

class PetsSwipePage extends StatelessWidget {
  final PetController petController = Get.put(PetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Obx(
        () => Stack(
          children: [
            PageView.builder(
              itemCount: petController.pets.length,
              onPageChanged: (index) {
                petController.currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                final pet = petController.pets[index];
                return _buildPetCard(context, pet);
              },
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: _buildActionButtons(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de agregar nuevo animal
          Get.toNamed('/newpet');
        },
        child: const Icon(Icons.add),
        tooltip: 'Agregar Animal',
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Pet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                pet.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              pet.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              pet.breed,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              pet.description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cake, color: Colors.pinkAccent),
                SizedBox(width: 5),
                Text(pet.age),
                SizedBox(width: 20),
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 5),
                Text(pet.location),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: "dislike",
          onPressed: () {
            petController.dislikePet(
                petController.pets[petController.currentIndex.value]);
          },
          child: Icon(Icons.close, color: Colors.red),
          backgroundColor: Colors.white,
        ),
        FloatingActionButton(
          heroTag: "like",
          onPressed: () {
            petController
                .likePet(petController.pets[petController.currentIndex.value]);
          },
          child: Icon(Icons.favorite, color: Colors.pink),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
