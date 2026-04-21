import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tomato_disease/data/diseasemodel.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage == null
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image.file(File(_selectedImage!.path)),
                  ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Pick from Gallery'),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: _selectedImage == null
                    ? null
                    : () async {
                        await DiseaseData().sendImageToDiseasePage(
                            context, File(_selectedImage!.path));
                      },
                icon: const Icon(Icons.check),
                label: const Text('Analyze Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}