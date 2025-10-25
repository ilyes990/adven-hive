import 'package:adven_hive/core/adventure_repo_implmnt.dart';
import 'package:adven_hive/core/model/adventure_model.dart';

/// Mock repository for testing
class MockAdventureRepository implements AdventureRepository {
  String mockResponse = 'Backpack - Tent - Sleeping Bag';
  bool shouldThrowError = false;

  @override
  Future<String> generateItems(AdventureModel adventureModel) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (shouldThrowError) {
      throw Exception('Failed to generate items');
    }

    return mockResponse;
  }
}
