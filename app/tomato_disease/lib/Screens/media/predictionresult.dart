import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tomato_disease/Screens/diseases/diseasedetail.dart';

class PredictionResultPage extends StatelessWidget {
  final File imageFile;
  final Map<String, dynamic> disease;
  final double confidence;

  const PredictionResultPage({
    super.key,
    required this.imageFile,
    required this.disease,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.file(imageFile, fit: BoxFit.cover),
            ),
            const SizedBox(height: 30),
            
            // Display the prediction
            Text(
              'Predicted Disease:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              disease['Disease_Name'] ?? 'Unknown',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Display the confidence
            Text(
              'Confidence:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              '${(confidence * 100).toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 40),
            
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiseaseDetailsPage(
                          disease: disease,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info),
                  label: const Text('Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
