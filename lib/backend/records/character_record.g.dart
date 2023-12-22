// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CharacterRecord> _$characterRecordSerializer =
    new _$CharacterRecordSerializer();

class _$CharacterRecordSerializer
    implements StructuredSerializer<CharacterRecord> {
  @override
  final Iterable<Type> types = const [CharacterRecord, _$CharacterRecord];
  @override
  final String wireName = 'CharacterRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, CharacterRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdDate;
    if (value != null) {
      result
        ..add('createdDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.stats;
    if (value != null) {
      result
        ..add('stats')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                Map, const [const FullType(String), const FullType(dynamic)])));
    }
    value = object.gameId;
    if (value != null) {
      result
        ..add('game_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CharacterRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CharacterRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdDate':
          result.createdDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'stats':
          result.stats = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(dynamic)
              ])) as Map<String, dynamic>?;
          break;
        case 'game_id':
          result.gameId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CharacterRecord extends CharacterRecord {
  @override
  final String? name;
  @override
  final String? id;
  @override
  final DateTime? createdDate;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final Map<String, dynamic>? stats;
  @override
  final String? gameId;

  factory _$CharacterRecord([void Function(CharacterRecordBuilder)? updates]) =>
      (new CharacterRecordBuilder()..update(updates))._build();

  _$CharacterRecord._(
      {this.name,
      this.id,
      this.createdDate,
      this.description,
      this.imageUrl,
      this.stats,
      this.gameId})
      : super._();

  @override
  CharacterRecord rebuild(void Function(CharacterRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CharacterRecordBuilder toBuilder() =>
      new CharacterRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CharacterRecord &&
        name == other.name &&
        id == other.id &&
        createdDate == other.createdDate &&
        description == other.description &&
        imageUrl == other.imageUrl &&
        stats == other.stats &&
        gameId == other.gameId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, stats.hashCode);
    _$hash = $jc(_$hash, gameId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CharacterRecord')
          ..add('name', name)
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('description', description)
          ..add('imageUrl', imageUrl)
          ..add('stats', stats)
          ..add('gameId', gameId))
        .toString();
  }
}

class CharacterRecordBuilder
    implements Builder<CharacterRecord, CharacterRecordBuilder> {
  _$CharacterRecord? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  Map<String, dynamic>? _stats;
  Map<String, dynamic>? get stats => _$this._stats;
  set stats(Map<String, dynamic>? stats) => _$this._stats = stats;

  String? _gameId;
  String? get gameId => _$this._gameId;
  set gameId(String? gameId) => _$this._gameId = gameId;

  CharacterRecordBuilder();

  CharacterRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _id = $v.id;
      _createdDate = $v.createdDate;
      _description = $v.description;
      _imageUrl = $v.imageUrl;
      _stats = $v.stats;
      _gameId = $v.gameId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CharacterRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CharacterRecord;
  }

  @override
  void update(void Function(CharacterRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CharacterRecord build() => _build();

  _$CharacterRecord _build() {
    final _$result = _$v ??
        new _$CharacterRecord._(
            name: name,
            id: id,
            createdDate: createdDate,
            description: description,
            imageUrl: imageUrl,
            stats: stats,
            gameId: gameId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
