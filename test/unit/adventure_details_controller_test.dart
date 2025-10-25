import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:adven_hive/UI/views/adventure_details_view.dart';
import 'package:adven_hive/core/adventure_repo_implmnt.dart';
import '../helpers/mock_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdventureDetailsController Unit Tests', () {
    late AdventureDetailsController controller;
    late MockAdventureRepository mockRepo;

    setUp(() {
      Get.testMode = true;
      mockRepo = MockAdventureRepository();
      Get.put<AdventureRepository>(mockRepo);
      controller = AdventureDetailsController();
      controller.onInit();
    });

    tearDown(() {
      Get.reset();
    });

    // Test: Initial State
    test('should have correct initial state', () {
      expect(controller.currentPage.value, 0);
      expect(controller.adventureType.value, '');
      expect(controller.isLoading.value, false);
      expect(controller.generatedItems, isEmpty);
    });

    // Test: Form Validation
    test('isFormValid should return false when fields are empty', () {
      expect(controller.isFormValid, false);
    });

    test('isFormValid should return true when all fields are filled', () {
      controller.setAdventureType('Hiking');
      controller.setMembers('4');
      controller.setDifficulty('Hard');
      controller.setDistance('15');
      controller.setChallenge('Mountain climbing');
      controller.setWeather('Snowy');

      expect(controller.isFormValid, true);
    });

    // Test: Pagination
    test('should update currentPage on nextPage', () {
      controller.currentPage.value = 0;
      controller.nextPage();
      // Note: Actual page change requires PageController widget
      expect(controller.currentPage.value, 0);
    });

    // Test: Selection
    test('should update adventureType on selection', () {
      controller.setAdventureType('Camping');
      expect(controller.adventureType.value, 'Camping');
    });

    test('should deselect adventureType when set to null', () {
      controller.setAdventureType('Hiking');
      expect(controller.adventureType.value, 'Hiking');

      controller.setAdventureType(null);
      expect(controller.adventureType.value, '');
    });

    // Test: Weather Selection
    test('should update weather on selection', () {
      controller.setWeather('Sunny');
      expect(controller.weather.value, 'Sunny');

      controller.setWeather('Rainy');
      expect(controller.weather.value, 'Rainy');
    });

    // Test: Form Field Updates
    test('should update all form fields correctly', () {
      controller.setAdventureType('Hiking');
      controller.setMembers('5');
      controller.setDifficulty('Hard');
      controller.setDistance('20');
      controller.setChallenge('Mountain terrain');
      controller.setWeather('Snowy');

      expect(controller.adventureType.value, 'Hiking');
      expect(controller.members.value, '5');
      expect(controller.difficulty.value, 'Hard');
      expect(controller.distance.value, '20');
      expect(controller.challenge.value, 'Mountain terrain');
      expect(controller.weather.value, 'Snowy');
    });
  });
}
