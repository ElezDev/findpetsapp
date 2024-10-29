import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findpetapp/src/models/pet_model.dart';
import 'package:findpetapp/src/Page/PetsPost/controllers/pet_controller.dart';

class PetsSwipePage extends StatelessWidget {
  final PetController petController = Get.put(PetController());

   PetsSwipePage({super.key});

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
          Get.toNamed('/newpet');
        },
        tooltip: 'Agregar Animal',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPetCard(BuildContext context, Pet pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: pet.images.length,
                    onPageChanged: (index) {
                      petController.currentImageIndex.value = index;
                    },
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          pet.images[index],
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  // Indicadores de puntos
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pet.images.length, (index) {
                        return Obx(() {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color:
                                  petController.currentImageIndex.value == index
                                      ? Colors.pinkAccent
                                      : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          );
                        });
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    pet.breed,
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      pet.description,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake, color: Colors.pinkAccent),
                      const SizedBox(width: 5),
                      Text(
                        pet.age.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 20),
                      const Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(width: 5),
                      Text(
                        pet.location,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
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
          backgroundColor: Colors.white,
          tooltip: 'No me gusta',
          child: const Icon(Icons.close, color: Colors.red),
        ),
        FloatingActionButton(
          heroTag: "like",
          onPressed: () {
            petController
                .likePet(petController.pets[petController.currentIndex.value]);
          },
          backgroundColor: Colors.white,
          tooltip: 'Me gusta',
          child: const Icon(Icons.favorite, color: Colors.pink),
        ),
      ],
    );
  }
}