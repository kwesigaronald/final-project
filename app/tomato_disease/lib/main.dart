import 'package:tomato_disease/data/diseasemodel.dart';
import 'package:tomato_disease/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DiseaseData().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tomato Disease Detection',
      theme: ThemeData(
        useMaterial3: true,
        ),
      home: const Home(),
    );
  }
}