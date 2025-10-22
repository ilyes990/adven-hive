class AdventureModel {
  // Declare the fields
  final String type;
  final String members;
  final String difficulty;
  final String distance;
  final String challenge;
  final String weather;

  // New fields for adventure submission
  final String? id;
  final String? name;
  final DateTime? createdAt;
  final List<String> selectedItems;
  final Map<String, bool> packedItems;
  final String status; // 'draft', 'active', 'completed'

  // Constructor with required parameters
  AdventureModel({
    required this.type,
    required this.members,
    required this.difficulty,
    required this.distance,
    required this.challenge,
    required this.weather,
    this.id,
    this.name,
    this.createdAt,
    this.selectedItems = const [],
    this.packedItems = const {},
    this.status = 'draft',
  });

  // Generate adventure name from type
  String get generatedName {
    return '${type} Adventure';
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

  // Copy with method for updating
  AdventureModel copyWith({
    String? type,
    String? members,
    String? difficulty,
    String? distance,
    String? challenge,
    String? weather,
    String? id,
    String? name,
    DateTime? createdAt,
    List<String>? selectedItems,
    Map<String, bool>? packedItems,
    String? status,
  }) {
    return AdventureModel(
      type: type ?? this.type,
      members: members ?? this.members,
      difficulty: difficulty ?? this.difficulty,
      distance: distance ?? this.distance,
      challenge: challenge ?? this.challenge,
      weather: weather ?? this.weather,
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      selectedItems: selectedItems ?? this.selectedItems,
      packedItems: packedItems ?? this.packedItems,
      status: status ?? this.status,
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'members': members,
      'difficulty': difficulty,
      'distance': distance,
      'challenge': challenge,
      'weather': weather,
      'id': id,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'selectedItems': selectedItems,
      'packedItems': packedItems,
      'status': status,
    };
  }

  // Create model from JSON
  factory AdventureModel.fromJson(Map<String, dynamic> json) {
    return AdventureModel(
      type: json['type'] ?? '',
      members: json['members'] ?? '',
      difficulty: json['difficulty'] ?? '',
      distance: json['distance'] ?? '',
      challenge: json['challenge'] ?? '',
      weather: json['weather'] ?? '',
      id: json['id'],
      name: json['name'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      selectedItems: List<String>.from(json['selectedItems'] ?? []),
      packedItems: Map<String, bool>.from(json['packedItems'] ?? {}),
      status: json['status'] ?? 'draft',
    );
  }
}
