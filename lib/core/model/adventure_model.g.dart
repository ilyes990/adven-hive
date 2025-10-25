// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adventure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdventureModelImpl _$$AdventureModelImplFromJson(Map<String, dynamic> json) =>
    _$AdventureModelImpl(
      type: json['type'] as String,
      members: json['members'] as String,
      difficulty: json['difficulty'] as String,
      distance: json['distance'] as String,
      challenge: json['challenge'] as String,
      weather: json['weather'] as String,
      id: json['id'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      selectedItems: (json['selectedItems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      packedItems: (json['packedItems'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      status: json['status'] as String? ?? 'draft',
    );

Map<String, dynamic> _$$AdventureModelImplToJson(
        _$AdventureModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'members': instance.members,
      'difficulty': instance.difficulty,
      'distance': instance.distance,
      'challenge': instance.challenge,
      'weather': instance.weather,
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt?.toIso8601String(),
      'selectedItems': instance.selectedItems,
      'packedItems': instance.packedItems,
      'status': instance.status,
    };
