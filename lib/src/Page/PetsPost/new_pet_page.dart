import 'package:findpetapp/src/Page/PetsPost/controllers/pet_post_controller.dart';
import 'package:findpetapp/src/widgets/Seleccion_imagen_Modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class NewPetPage extends StatelessWidget {
  final PetPostController controller = Get.put(PetPostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Publicación de Mascota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: controller.imagenes.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Hacemos los ítems más grandes
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  // Botón para agregar imagen
                  if (index == controller.imagenes.length) {
                    return GestureDetector(
                      onTap: () => _mostrarOpcionesImagen(context),
                      child: DottedBorder(
                        color: Colors.pinkAccent,
                        
                        strokeWidth: 2,
                        dashPattern: [6, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 180, 
                          child: const Center(
                            child: Icon(Icons.add_a_photo,
                                size: 60,
                                color: Colors.pinkAccent), // Ícono más grande
                          ),
                        ),
                      ),
                    );
                  }

                  // Mostrar las imágenes seleccionadas
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180, // Hacemos las imágenes más grandes
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: FileImage(controller.imagenes[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: () =>
                                  _mostrarOpcionesCambioImagen(context, index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => controller.eliminarImagen(index),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarOpcionesImagen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SeleccionImagenModal(
          onCameraSelected: () {
            controller.seleccionarImagen(true);
          },
          onGallerySelected: () {
            controller.seleccionarImagen(false);
          },
        );
      },
    );
  }

  void _mostrarOpcionesCambioImagen(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return SeleccionImagenModal(
          onCameraSelected: () {
            controller.cambiarImagen(index, true);
          },
          onGallerySelected: () {
            controller.cambiarImagen(index, false);
          },
        );
      },
    );
  }
}
