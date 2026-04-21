import 'package:flutter/material.dart';
import 'package:tomato_disease/Screens/diseases/diseasedetail.dart';
import 'package:tomato_disease/data/diseasemodel.dart';

class DiseasePage extends StatelessWidget {
  const DiseasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomato Plant Diseases'),
      ),
      body:
          // print(provider.DiseaseDetails[0]['Disease_Name']);
          ListView.builder(
        itemCount: DiseaseData().diseaseList.length,
        itemBuilder: (context, index) {
          var disease = DiseaseData().diseaseList[index];
          return Card(
            child: ListTile(
              title: Text(disease['Disease_Name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseDetailsPage(
                      disease: disease,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
