import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tomato_disease/Screens/media/predictionresult.dart';

class DiseaseData {
  static final DiseaseData _instance = DiseaseData._internal();
  factory DiseaseData() => _instance;
  DiseaseData._internal();

  List<Map<String, dynamic>> diseaseList = [];
  Interpreter? _interpreter;

  // 1. Load Disease JSON List and TFlite Model
  Future<void> initialize() async {
    if (diseaseList.isEmpty) {
      final jsonString = await rootBundle.loadString('asset/tomatodiseases/disease.json');
      diseaseList = json.decode(jsonString).cast<Map<String, dynamic>>();
    }

    if (_interpreter == null) {
      try {
        _interpreter = await Interpreter.fromAsset('asset/model/model.tflite');
      } catch (e) {
        debugPrint('Failed to load model: $e');
      }
    }
  }

  // Load and resize image to model's expected input size
  List<dynamic> preprocessImage(File imageFile) {
    final image = img.decodeImage(imageFile.readAsBytesSync())!;
    final resizedImage = img.copyResize(image, width: 224, height: 224);

    final input = List.generate(224 * 224 * 3, (index) => 0.0).reshape([1, 224, 224, 3]);

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resizedImage.getPixel(x, y);
        input[0][y][x][0] = img.getRed(pixel).toDouble();   // R
        input[0][y][x][1] = img.getGreen(pixel).toDouble(); // G
        input[0][y][x][2] = img.getBlue(pixel).toDouble();  // B
      }
    }
    return input;
  }

  // Run inference and get labels with confidence
  Future<Map<String, dynamic>> classifyImage(File imageFile) async {
    final input = preprocessImage(imageFile);
    final output = List.filled(10, 0.0).reshape([1, 10]);

    // Run inference
    _interpreter!.run(input, output);

    double maxScore = output[0][0];
    int maxIndex = 0;
    for (int i = 0; i < output[0].length; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIndex = i;
      }
    }
    return {'index': maxIndex, 'confidence': maxScore};
  }

  Future<void> sendImageToDiseasePage(
    BuildContext context, dynamic selectedImage) async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      // Show loading indicator
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }

      // Classify the image
      File imageFile = selectedImage is File ? selectedImage : File(selectedImage.path);
      final classificationResult = await classifyImage(imageFile);
      int predictedIndex = classificationResult['index'];
      double confidence = classificationResult['confidence'];

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Find disease by matching the predicted index with the "id" field in JSON
      Map<String, dynamic>? matchedDisease = diseaseList.firstWhere(
        (disease) => disease['id'] == predictedIndex,
        orElse: () => {},
      );

      if (matchedDisease.isNotEmpty) {
        if (context.mounted) {
          debugPrint('Matched disease: ${matchedDisease['Disease_Name']}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PredictionResultPage(
                imageFile: imageFile,
                disease: matchedDisease,
                confidence: confidence,
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid prediction result')),
          );
        }
      }
    } catch (e) {
      // Close loading dialog if still open
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }
}