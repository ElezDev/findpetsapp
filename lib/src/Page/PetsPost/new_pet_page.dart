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
  final LocationController locationController = Get.put(LocationController());
  final _formKey = GlobalKey<FormState>();

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
          child: SingleChildScrollView(
            // Permite el desplazamiento si hay mucho contenido
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Desactiva el desplazamiento interno
                    itemCount: controller.imagenes.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
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
                              decoration: BoxDecoration(
                                color:
                                    Colors.white, // Fondo blanco para contraste
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0,
                                        3), // Cambiar la posición de la sombra
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(Icons.add_a_photo,
                                    size: 60, color: Colors.pinkAccent),
                              ),
                            ),
                          ),
                        );
                      }

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
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () => _mostrarOpcionesCambioImagen(
                                      context, index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      controller.eliminarImagen(index),
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
                _buildTextFormField('Nombre', 'Por favor ingresa un nombre',
                    (value) => mascotaData['name'] = value!),
                _buildTextFormField('Edad', 'Por favor ingresa una edad',
                    (value) => mascotaData['age'] = int.parse(value!),
                    keyboardType: TextInputType.number),
                _buildTextFormField('Raza', 'Por favor ingresa una raza',
                    (value) => mascotaData['breed'] = value!),
                _buildTextFormField('Tamaño', 'Por favor ingresa un tamaño',
                    (value) => mascotaData['size'] = value!),
                _buildTextFormField(
                    'Descripción',
                    'Por favor ingresa una descripción',
                    (value) => mascotaData['description'] = value!),
                _buildTextFormField(
                    'Ubicación',
                    'Por favor ingresa una ubicación',
                    (value) => mascotaData['location'] = value!),
                _buildTextFormField(
                    'Estado de adopción',
                    'Por favor ingresa el estado de adopción',
                    (value) => mascotaData['adoption_status'] = value!),

                const SizedBox(height: 20),
                CustomButton(
                  text: 'Publicar',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (locationController.currentPosition.value != null) {
                        mascotaData['latitude'] =
                            locationController.currentPosition.value!.latitude;
                        mascotaData['longitude'] =
                            locationController.currentPosition.value!.longitude;
                      }

                      controller.publicarMascota(mascotaData);
                    }
                  },
                  backgroundColor: Colors.pinkAccent,
                  textColor: Colors.white,
                  // Añadir un poco de elevación
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String label, String errorText, Function(String?)? onSaved,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Bordes redondeados
            borderSide: BorderSide(color: Colors.pinkAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: Colors.pinkAccent,
                width: 2), // Bordes más gruesos al enfocar
          ),
        ),
        validator: (value) => value!.isEmpty ? errorText : null,
        onSaved: onSaved,
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
