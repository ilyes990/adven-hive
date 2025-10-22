import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BadUIController extends GetxController {
  final adventureType = ''.obs;
  final members = ''.obs;
  final difficulty = ''.obs;
  final distance = ''.obs;
  final challenge = ''.obs;
  final weather = ''.obs;

  final List<String> adventureTypes = [
    'Hiking',
    'Camping',
    'BikePacking',
    'RoadTrip'
  ];

  final List<String> weatherConditions = [
    'Sunny',
    'Rainy',
    'Snowy',
    'Mixed/Unpredictable'
  ];

  final List<String> difficultyLevels = ['Easy', 'Medium', 'Hard'];

  void setAdventureType(String? type) {
    adventureType.value = type ?? '';
  }

  void setMembers(String value) {
    members.value = value;
  }

  void setDifficulty(String? value) {
    difficulty.value = value ?? '';
  }

  void setDistance(String value) {
    distance.value = value;
  }

  void setChallenge(String value) {
    challenge.value = value;
  }

  void setWeather(String? condition) {
    weather.value = condition ?? '';
  }
}

class BadUIView extends StatelessWidget {
  const BadUIView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BadUIController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Form - OLD UI'),
        backgroundColor: Colors.grey[300],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Plan Your Adventure',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Adventure Type
              const Text(
                'Adventure Type:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Obx(() => Column(
                    children: controller.adventureTypes.map((type) {
                      return RadioListTile<String>(
                        title: Text(
                          type,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: type,
                        groupValue: controller.adventureType.value.isEmpty
                            ? null
                            : controller.adventureType.value,
                        onChanged: controller.setAdventureType,
                        dense: true,
                      );
                    }).toList(),
                  )),

              const SizedBox(height: 16),

              // Members
              const Text(
                'Number of Members:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: controller.setMembers,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter number',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 16),

              // Difficulty
              const Text(
                'Difficulty:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                    value: controller.difficulty.value.isEmpty
                        ? null
                        : controller.difficulty.value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: controller.difficultyLevels.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(
                          level,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: controller.setDifficulty,
                    hint: const Text(
                      'Select difficulty',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  )),

              const SizedBox(height: 16),

              // Distance
              const Text(
                'Distance (Km):',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: controller.setDistance,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter distance',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 16),

              // Challenge
              const Text(
                'Challenges:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: controller.setChallenge,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Describe challenges',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
              ),

              const SizedBox(height: 16),

              // Weather
              const Text(
                'Weather:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Obx(() => Column(
                    children: controller.weatherConditions.map((condition) {
                      return RadioListTile<String>(
                        title: Text(
                          condition,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: condition,
                        groupValue: controller.weather.value.isEmpty
                            ? null
                            : controller.weather.value,
                        onChanged: controller.setWeather,
                        dense: true,
                      );
                    }).toList(),
                  )),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Form Submitted',
                      'Adventure form completed!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Comparison Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/adventure-details');
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    foregroundColor: Colors.green,
                  ),
                  child: const Text(
                    '✨ See Modern Version ✨',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
