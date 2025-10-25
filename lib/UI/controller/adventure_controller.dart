import 'package:get/get.dart';
import '../../core/model/adventure_model.dart';
import '../../core/adventure_repo_implmnt.dart';

class AdventureController extends GetxController {
  final AdventureRepository _repository = Get.find<AdventureRepository>();

  final _generatedItems = ''.obs;
  final _isLoading = false.obs;
  final Rx<String?> _error = Rx<String?>(null);

  // Getters
  String get generatedItems => _generatedItems.value;
  bool get isLoading => _isLoading.value;
  String? get error => _error.value;

  // Generate adventure items
  Future<void> generateItems(AdventureModel adventureModel) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final items = await _repository.generateItems(adventureModel);
      _generatedItems.value = items;
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  // Clear generated items
  void clearItems() {
    _generatedItems.value = '';
    _error.value = null;
  }
}
