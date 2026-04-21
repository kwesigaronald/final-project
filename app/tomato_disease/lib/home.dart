import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tomato_disease/Screens/media/camerapage.dart';
import 'package:tomato_disease/Screens/media/gallerypage.dart';
import 'package:tomato_disease/Screens/diseases/diseasepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if(!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tomato Disease Prediction'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            // This centers the cards from top to bottom
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOptionCard(Icons.camera_alt, "Camera", () async {
                final navigator = Navigator.of(context);
                final cameras = await availableCameras();
                navigator.push(
                  MaterialPageRoute(
                    builder: (_) => CameraPage(cameras: cameras),
                  ),
                );
              }),
              _buildOptionCard(
                  Icons.photo,
                  "Gallery",
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GalleryPage(),
                      ))),
              _buildOptionCard(
                Icons.info,
                "Diseases",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiseasePage(),
                    ))),
            ],
          ),
        ),
      ),
    );     
  }

  Widget _buildOptionCard(IconData icon, String title, VoidCallback onTap) {
    return SizedBox(
      // Defining width and height to maintain the card appearance in a Column
      width: 250, 
      height: 150,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.green,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontSize: 18)),
              ],
            )
          )
        )
      ),
    );
  }  
}