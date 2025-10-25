// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adventure_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdventureModel _$AdventureModelFromJson(Map<String, dynamic> json) {
  return _AdventureModel.fromJson(json);
}

/// @nodoc
mixin _$AdventureModel {
  String get type => throw _privateConstructorUsedError;
  String get members => throw _privateConstructorUsedError;
  String get difficulty => throw _privateConstructorUsedError;
  String get distance => throw _privateConstructorUsedError;
  String get challenge => throw _privateConstructorUsedError;
  String get weather => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<String> get selectedItems => throw _privateConstructorUsedError;
  Map<String, bool> get packedItems => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this AdventureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdventureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdventureModelCopyWith<AdventureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdventureModelCopyWith<$Res> {
  factory $AdventureModelCopyWith(
          AdventureModel value, $Res Function(AdventureModel) then) =
      _$AdventureModelCopyWithImpl<$Res, AdventureModel>;
  @useResult
  $Res call(
      {String type,
      String members,
      String difficulty,
      String distance,
      String challenge,
      String weather,
      String? id,
      String? name,
      DateTime? createdAt,
      List<String> selectedItems,
      Map<String, bool> packedItems,
      String status});
}

/// @nodoc
class _$AdventureModelCopyWithImpl<$Res, $Val extends AdventureModel>
    implements $AdventureModelCopyWith<$Res> {
  _$AdventureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdventureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? members = null,
    Object? difficulty = null,
    Object? distance = null,
    Object? challenge = null,
    Object? weather = null,
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? selectedItems = null,
    Object? packedItems = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedItems: null == selectedItems
          ? _value.selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      packedItems: null == packedItems
          ? _value.packedItems
          : packedItems // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdventureModelImplCopyWith<$Res>
    implements $AdventureModelCopyWith<$Res> {
  factory _$$AdventureModelImplCopyWith(_$AdventureModelImpl value,
          $Res Function(_$AdventureModelImpl) then) =
      __$$AdventureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String members,
      String difficulty,
      String distance,
      String challenge,
      String weather,
      String? id,
      String? name,
      DateTime? createdAt,
      List<String> selectedItems,
      Map<String, bool> packedItems,
      String status});
}

/// @nodoc
class __$$AdventureModelImplCopyWithImpl<$Res>
    extends _$AdventureModelCopyWithImpl<$Res, _$AdventureModelImpl>
    implements _$$AdventureModelImplCopyWith<$Res> {
  __$$AdventureModelImplCopyWithImpl(
      _$AdventureModelImpl _value, $Res Function(_$AdventureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdventureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? members = null,
    Object? difficulty = null,
    Object? distance = null,
    Object? challenge = null,
    Object? weather = null,
    Object? id = freezed,
    Object? name = freezed,
    Object? createdAt = freezed,
    Object? selectedItems = null,
    Object? packedItems = null,
    Object? status = null,
  }) {
    return _then(_$AdventureModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String,
      challenge: null == challenge
          ? _value.challenge
          : challenge // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      selectedItems: null == selectedItems
          ? _value._selectedItems
          : selectedItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      packedItems: null == packedItems
          ? _value._packedItems
          : packedItems // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdventureModelImpl extends _AdventureModel {
  const _$AdventureModelImpl(
      {required this.type,
      required this.members,
      required this.difficulty,
      required this.distance,
      required this.challenge,
      required this.weather,
      this.id,
      this.name,
      this.createdAt,
      final List<String> selectedItems = const [],
      final Map<String, bool> packedItems = const {},
      this.status = 'draft'})
      : _selectedItems = selectedItems,
        _packedItems = packedItems,
        super._();

  factory _$AdventureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdventureModelImplFromJson(json);

  @override
  final String type;
  @override
  final String members;
  @override
  final String difficulty;
  @override
  final String distance;
  @override
  final String challenge;
  @override
  final String weather;
  @override
  final String? id;
  @override
  final String? name;
  @override
  final DateTime? createdAt;
  final List<String> _selectedItems;
  @override
  @JsonKey()
  List<String> get selectedItems {
    if (_selectedItems is EqualUnmodifiableListView) return _selectedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedItems);
  }

  final Map<String, bool> _packedItems;
  @override
  @JsonKey()
  Map<String, bool> get packedItems {
    if (_packedItems is EqualUnmodifiableMapView) return _packedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_packedItems);
  }

  @override
  @JsonKey()
  final String status;

  @override
  String toString() {
    return 'AdventureModel(type: $type, members: $members, difficulty: $difficulty, distance: $distance, challenge: $challenge, weather: $weather, id: $id, name: $name, createdAt: $createdAt, selectedItems: $selectedItems, packedItems: $packedItems, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdventureModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.members, members) || other.members == members) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.challenge, challenge) ||
                other.challenge == challenge) &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._selectedItems, _selectedItems) &&
            const DeepCollectionEquality()
                .equals(other._packedItems, _packedItems) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      members,
      difficulty,
      distance,
      challenge,
      weather,
      id,
      name,
      createdAt,
      const DeepCollectionEquality().hash(_selectedItems),
      const DeepCollectionEquality().hash(_packedItems),
      status);

  /// Create a copy of AdventureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdventureModelImplCopyWith<_$AdventureModelImpl> get copyWith =>
      __$$AdventureModelImplCopyWithImpl<_$AdventureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdventureModelImplToJson(
      this,
    );
  }
}

abstract class _AdventureModel extends AdventureModel {
  const factory _AdventureModel(
      {required final String type,
      required final String members,
      required final String difficulty,
      required final String distance,
      required final String challenge,
      required final String weather,
      final String? id,
      final String? name,
      final DateTime? createdAt,
      final List<String> selectedItems,
      final Map<String, bool> packedItems,
      final String status}) = _$AdventureModelImpl;
  const _AdventureModel._() : super._();

  factory _AdventureModel.fromJson(Map<String, dynamic> json) =
      _$AdventureModelImpl.fromJson;

  @override
  String get type;
  @override
  String get members;
  @override
  String get difficulty;
  @override
  String get distance;
  @override
  String get challenge;
  @override
  String get weather;
  @override
  String? get id;
  @override
  String? get name;
  @override
  DateTime? get createdAt;
  @override
  List<String> get selectedItems;
  @override
  Map<String, bool> get packedItems;
  @override
  String get status;

  /// Create a copy of AdventureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdventureModelImplCopyWith<_$AdventureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
