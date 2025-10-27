import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/model/adventure_model.dart';

class AdventureStorageController extends GetxController {
  // Observable list of saved adventures
  final RxList<AdventureModel> savedAdventures = <AdventureModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error state
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedAdventures();
  }

  // Load saved adventures from local storage
  Future<void> loadSavedAdventures() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final prefs = await SharedPreferences.getInstance();
      final adventuresJson = prefs.getStringList('saved_adventures') ?? [];

      final adventures = adventuresJson
          .map((json) => AdventureModel.fromJson(jsonDecode(json)))
          .toList();

      // Sort by creation date (newest first)
      adventures.sort((a, b) => (b.createdAt ?? DateTime.now())
          .compareTo(a.createdAt ?? DateTime.now()));

      savedAdventures.value = adventures;

      print('Loaded ${adventures.length} saved adventures');
    } catch (e) {
      print('Error loading saved adventures: $e');
      errorMessage.value = 'Failed to load saved adventures';
    } finally {
      isLoading.value = false;
    }
  }

  // Save a new adventure
  Future<bool> saveAdventure(AdventureModel adventure) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Generate unique ID if not provided
      final adventureWithId = adventure.id == null
          ? adventure.copyWith(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              createdAt: DateTime.now(),
              name: adventure.generatedName,
            )
          : adventure;

      // Add to list
      savedAdventures.add(adventureWithId);

      // Save to local storage
      await _saveToStorage();

      print('Saved adventure: ${adventureWithId.name}');
      return true;
    } catch (e) {
      print('Error saving adventure: $e');
      errorMessage.value = 'Failed to save adventure';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Update an existing adventure
  Future<bool> updateAdventure(AdventureModel adventure) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final index = savedAdventures.indexWhere((a) => a.id == adventure.id);
      if (index != -1) {
        savedAdventures[index] = adventure;
        await _saveToStorage();
        print('Updated adventure: ${adventure.name}');
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating adventure: $e');
      errorMessage.value = 'Failed to update adventure';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete an adventure
  Future<bool> deleteAdventure(String adventureId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      savedAdventures.removeWhere((adventure) => adventure.id == adventureId);
      await _saveToStorage();

      print('Deleted adventure: $adventureId');
      return true;
    } catch (e) {
      print('Error deleting adventure: $e');
      errorMessage.value = 'Failed to delete adventure';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get adventure by ID
  AdventureModel? getAdventureById(String id) {
    try {
      return savedAdventures.firstWhere((adventure) => adventure.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get adventures by status
  List<AdventureModel> getAdventuresByStatus(String status) {
    return savedAdventures
        .where((adventure) => adventure.status == status)
        .toList();
  }

  // Get completed adventures
  List<AdventureModel> get completedAdventures {
    return savedAdventures.where((adventure) => adventure.isCompleted).toList();
  }

  // Get active adventures
  List<AdventureModel> get activeAdventures {
    return savedAdventures
        .where((adventure) => adventure.status == 'active')
        .toList();
  }

  Future<void> clearAllAdventures() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      savedAdventures.clear();
      await _saveToStorage();

      print('Cleared all adventures');
    } catch (e) {
      print('Error clearing adventures: $e');
      errorMessage.value = 'Failed to clear adventures';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final adventuresJson = savedAdventures
        .map((adventure) => jsonEncode(adventure.toJson()))
        .toList();
    await prefs.setStringList('saved_adventures', adventuresJson);
  }

  // Get adventure statistics
  Map<String, dynamic> get adventureStats {
    final total = savedAdventures.length;
    final completed = completedAdventures.length;
    final active = activeAdventures.length;
    final draft = getAdventuresByStatus('draft').length;

    return {
      'total': total,
      'completed': completed,
      'active': active,
      'draft': draft,
      'completionRate': total > 0 ? (completed / total * 100).round() : 0,
    };
  }
}
