import 'package:tomato_disease/data/diseasemodel.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.picture});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(File(picture.path), fit: BoxFit.cover, width: 250 ),
          ),
          const SizedBox(height: 30),
          Text(picture.name),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh, size: 30),
              ),
              IconButton(
                onPressed: () async {
                  await DiseaseData().sendImageToDiseasePage(context, File(picture.path));
                },
                icon: const Icon(Icons.check, size: 30),
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}