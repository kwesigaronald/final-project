import 'package:flutter/material.dart';

class DiseaseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> disease;

  const DiseaseDetailsPage({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease['Disease_Name']),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // disease image
                      _buildImage(),
                      const SizedBox(height: 12.0),
                      Text(
                        'Name: ${disease['Disease_Name']}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    
                      const SizedBox(height: 32.0),

                      //description
                      showdetail('Description'),

                      //cause
                      showdetail('Causes'),

                      const SizedBox(height: 16.0),

                      //symptoms
                      showdetail('Symptoms'),

                      //management tip
                      showdetail('Management_Tips'),

                      // treatment
                      showdetail('Treatment'),

                      //prevention
                      showdetail('Prevention'),

                      // Affected_Plant_Parts
                      showdetail('Affected_Plant_Parts'),

                      //Spread_and_Impact
                      showdetail('Spread_and_Impact')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } 

  Widget showdetail(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          disease[title]?.toString() ?? '',
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildImage() {
    const assetMap = {
      'Bacterial Spot': 'asset/images/Bacterial_Spot.png',
      'Early Blight': 'asset/images/Early_Blight.png',
      'Late Blight': 'asset/images/Late_Blight.png',
      'Leaf Mold': 'asset/images/Leaf_Mold.png',
      'Septoria Leaf Spot': 'asset/images/Septora_Leaf_Spot.png',
      'Target Spot': 'asset/images/Target_Spot.png',
      'Tomato Mosaic Virus': 'asset/images/Tomato_Mosaic_Virus.png',
      'Tomato Spider Mite': 'asset/images/Tomato_Spider_Mite.png',
      'Tomato Yellow Leaf Curl Virus': 'asset/images/Tomato_Yellow_Leaf_Curl_Virus.png',
    };

    final diseaseName = disease['Disease_Name']?.toString();
    final mapped = (diseaseName != null && assetMap.containsKey(diseaseName))
        ? assetMap[diseaseName]
        : null;

    // prefer explicit image field if provided
    final imgVal = (disease['image'] ?? disease['Image'] ?? disease['img'])?.toString();

    final path = mapped ?? (imgVal != null && imgVal.isNotEmpty ? imgVal : null);

    if (path != null && path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          path,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => Container(
            height: 200,
            color: Colors.grey[200],
            child: Icon(Icons.broken_image, size: 64, color: Colors.grey[600]),
          ),
        ),
      );
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(Icons.image, size: 64, color: Colors.grey[600]),
    );
  }
}