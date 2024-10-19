import 'package:findpetapp/src/Utils/Styles.dart';
import 'package:flutter/material.dart';

class SeleccionImagenModal extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;

  const SeleccionImagenModal({
    Key? key,
    required this.onCameraSelected,
    required this.onGallerySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Seleccionar Imagen',
        style: titleGeneral(context),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent.shade700,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            label: const Text(
              'Tomar Foto',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              onCameraSelected();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.photo_library, color: Colors.white),
            label: const Text(
              'Seleccionar desde Galería',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              onGallerySelected(); // Llamada al callback para la galería
              Navigator.of(context).pop(); // Cerrar el modal
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
