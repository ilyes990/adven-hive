import 'package:freezed_annotation/freezed_annotation.dart';

part 'adventure_model.freezed.dart';
part 'adventure_model.g.dart';

@freezed
class AdventureModel with _$AdventureModel {
  const AdventureModel._();

  const factory AdventureModel({
    required String type,
    required String members,
    required String difficulty,
    required String distance,
    required String challenge,
    required String weather,
    String? id,
    String? name,
    DateTime? createdAt,
    @Default([]) List<String> selectedItems,
    @Default({}) Map<String, bool> packedItems,
    @Default('draft') String status, // 'draft', 'active', 'completed'
  }) = _AdventureModel;

  factory AdventureModel.fromJson(Map<String, dynamic> json) =>
      _$AdventureModelFromJson(json);

  // Generate adventure name from type
  String get generatedName {
    return '$type Adventure';
  }

  // Get packing progress percentage
  double get packingProgress {
    if (selectedItems.isEmpty) return 0.0;
    final packedCount = packedItems.values.where((packed) => packed).length;
    return packedCount / selectedItems.length;
  }

  // Check if adventure is completed
  bool get isCompleted {
    return packingProgress == 1.0;
  }
}
