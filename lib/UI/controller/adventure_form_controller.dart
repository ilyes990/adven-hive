import 'package:get/get.dart';
import '../../core/model/adventure_model.dart';

class AdventureFormController extends GetxController {
  // Reactive form data
  final _formData = <String, String?>{
    'type': null,
    'members': null,
    'difficulty': null,
    'distance': null,
    'challenge': null,
    'weather': null,
  }.obs;

  // Generic getter
  String? getValue(String key) => _formData[key];

  // Generic setter
  void setValue(String key, String? value) {
    _formData[key] = value;
    _formData.refresh();
  }

  // Convenience getters
  String? get type => getValue('type');
  String? get members => getValue('members');
  String? get difficulty => getValue('difficulty');
  String? get distance => getValue('distance');
  String? get challenge => getValue('challenge');
  String? get weather => getValue('weather');

  // Check if form is valid
  bool get isFormValid =>
      _formData.values.every((value) => value != null && value.isNotEmpty);

  // Create AdventureModel from form data
  AdventureModel? get adventureModel {
    if (!isFormValid) return null;

    return AdventureModel(
      type: _formData['type']!,
      members: _formData['members']!,
      difficulty: _formData['difficulty']!,
      distance: _formData['distance']!,
      challenge: _formData['challenge']!,
      weather: _formData['weather']!,
    );
  }

  // Reset form
  void reset() {
    _formData.updateAll((key, value) => null);
    _formData.refresh();
  }
}
