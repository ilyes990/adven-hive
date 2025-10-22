import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/adventure_model.dart';
import '../../core/adventure_repo_implmnt.dart';
import '../../shared/locator.dart';

class AdventureController extends ChangeNotifier {
  final AdventureRepository _repository = Get.find<AdventureRepository>();

  String _generatedItems = '';
  bool _isLoading = false;
  String? _error;

  // Getters
  String get generatedItems => _generatedItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Generate adventure items
  Future<void> generateItems(AdventureModel adventureModel) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final items = await _repository.generateItems(adventureModel);
      _generatedItems = items;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear generated items
  void clearItems() {
    _generatedItems = '';
    _error = null;
    notifyListeners();
  }
}
