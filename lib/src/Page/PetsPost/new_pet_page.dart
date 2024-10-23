import 'package:findpetapp/src/Page/Home/location_controller.dart';
import 'package:findpetapp/src/Page/PetsPost/controllers/pet_post_controller.dart';
import 'package:findpetapp/src/widgets/Seleccion_imagen_Modal.dart';
import 'package:findpetapp/src/widgets/custom_app_bar.dart';
import 'package:findpetapp/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class NewPetPage extends StatelessWidget {
  final PetPostController controller = Get.put(PetPostController());
  final LocationController locationController = Get.put(LocationController()); // Instancia de LocationController
  final _formKey = GlobalKey<FormState>();
  
  // Mapa para guardar datos de la mascota
  final Map<String, dynamic> mascotaData = {
    'name': '',
    'age': 0,
    'breed': '',
    'size': '',
    'description': '',
    'location': '',
    'adoption_status': '',
    'latitude': 0.0,
    'longitude': 0.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Publicar Mascota',
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              Obx(() {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.imagenes.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
                              child: Icon(Icons.add_a_photo, size: 60, color: Colors.pinkAccent),
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
                          height: 180,
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
                                onPressed: () => _mostrarOpcionesCambioImagen(context, index),
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
              
              // Campos del formulario para la mascota
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre' : null,
                onSaved: (value) => mascotaData['name'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Por favor ingresa una edad' : null,
                onSaved: (value) => mascotaData['age'] = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Raza'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa una raza' : null,
                onSaved: (value) => mascotaData['breed'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tamaño'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un tamaño' : null,
                onSaved: (value) => mascotaData['size'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa una descripción' : null,
                onSaved: (value) => mascotaData['description'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ubicación'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa una ubicación' : null,
                onSaved: (value) => mascotaData['location'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Estado de adopción'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa el estado de adopción' : null,
                onSaved: (value) => mascotaData['adoption_status'] = value!,
              ),

              const SizedBox(height: 20),
              CustomButton(
                text: 'Publicar', // Texto del botón
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save(); // Guarda los datos del formulario
                    
                    // Asigna la latitud y longitud desde el LocationController
                    if (locationController.currentPosition.value != null) {
                      mascotaData['latitude'] = locationController.currentPosition.value!.latitude;
                      mascotaData['longitude'] = locationController.currentPosition.value!.longitude;
                    }

                    // Llama al método para publicar la mascota
                    controller.publicarMascota(mascotaData);
                  }
                },
                backgroundColor: Colors.pinkAccent,
                textColor: Colors.white,
              ),
            ],
          ),
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
