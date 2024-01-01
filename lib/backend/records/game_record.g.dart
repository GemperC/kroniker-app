// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GameRecord> _$gameRecordSerializer = new _$GameRecordSerializer();

class _$GameRecordSerializer implements StructuredSerializer<GameRecord> {
  @override
  final Iterable<Type> types = const [GameRecord, _$GameRecord];
  @override
  final String wireName = 'GameRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, GameRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.gameTitle;
    if (value != null) {
      result
        ..add('gameTitle')
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
    value = object.created_date;
    if (value != null) {
      result
        ..add('created_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.bannerImageUrl;
    if (value != null) {
      result
        ..add('bannerImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.gameMasterEmail;
    if (value != null) {
      result
        ..add('gameMasterEmail')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userEmails;
    if (value != null) {
      result
        ..add('userEmails')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.characters;
    if (value != null) {
      result
        ..add('characters')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.setting;
    if (value != null) {
      result
        ..add('setting')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rulesUrl;
    if (value != null) {
      result
        ..add('rulesUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.customItems;
    if (value != null) {
      result
        ..add('customItems')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    value = object.aspects;
    if (value != null) {
      result
        ..add('aspects')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(
                  DocumentReference, const [const FullType.nullable(Object)])
            ])));
    }
    return result;
  }

  @override
  GameRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GameRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'gameTitle':
          result.gameTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_date':
          result.created_date = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'bannerImageUrl':
          result.bannerImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'gameMasterEmail':
          result.gameMasterEmail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'userEmails':
          result.userEmails.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'characters':
          result.characters.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'setting':
          result.setting = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rulesUrl':
          result.rulesUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'customItems':
          result.customItems.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
        case 'aspects':
          result.aspects.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(
                    DocumentReference, const [const FullType.nullable(Object)])
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GameRecord extends GameRecord {
  @override
  final String? gameTitle;
  @override
  final String? id;
  @override
  final DateTime? created_date;
  @override
  final String? bannerImageUrl;
  @override
  final String? description;
  @override
  final String? gameMasterEmail;
  @override
  final BuiltList<String>? userEmails;
  @override
  final BuiltList<DocumentReference<Object?>>? characters;
  @override
  final String? setting;
  @override
  final String? rulesUrl;
  @override
  final BuiltList<DocumentReference<Object?>>? customItems;
  @override
  final BuiltList<DocumentReference<Object?>>? aspects;

  factory _$GameRecord([void Function(GameRecordBuilder)? updates]) =>
      (new GameRecordBuilder()..update(updates))._build();

  _$GameRecord._(
      {this.gameTitle,
      this.id,
      this.created_date,
      this.bannerImageUrl,
      this.description,
      this.gameMasterEmail,
      this.userEmails,
      this.characters,
      this.setting,
      this.rulesUrl,
      this.customItems,
      this.aspects})
      : super._();

  @override
  GameRecord rebuild(void Function(GameRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GameRecordBuilder toBuilder() => new GameRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GameRecord &&
        gameTitle == other.gameTitle &&
        id == other.id &&
        created_date == other.created_date &&
        bannerImageUrl == other.bannerImageUrl &&
        description == other.description &&
        gameMasterEmail == other.gameMasterEmail &&
        userEmails == other.userEmails &&
        characters == other.characters &&
        setting == other.setting &&
        rulesUrl == other.rulesUrl &&
        customItems == other.customItems &&
        aspects == other.aspects;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gameTitle.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, created_date.hashCode);
    _$hash = $jc(_$hash, bannerImageUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, gameMasterEmail.hashCode);
    _$hash = $jc(_$hash, userEmails.hashCode);
    _$hash = $jc(_$hash, characters.hashCode);
    _$hash = $jc(_$hash, setting.hashCode);
    _$hash = $jc(_$hash, rulesUrl.hashCode);
    _$hash = $jc(_$hash, customItems.hashCode);
    _$hash = $jc(_$hash, aspects.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GameRecord')
          ..add('gameTitle', gameTitle)
          ..add('id', id)
          ..add('created_date', created_date)
          ..add('bannerImageUrl', bannerImageUrl)
          ..add('description', description)
          ..add('gameMasterEmail', gameMasterEmail)
          ..add('userEmails', userEmails)
          ..add('characters', characters)
          ..add('setting', setting)
          ..add('rulesUrl', rulesUrl)
          ..add('customItems', customItems)
          ..add('aspects', aspects))
        .toString();
  }
}

class GameRecordBuilder implements Builder<GameRecord, GameRecordBuilder> {
  _$GameRecord? _$v;

  String? _gameTitle;
  String? get gameTitle => _$this._gameTitle;
  set gameTitle(String? gameTitle) => _$this._gameTitle = gameTitle;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _created_date;
  DateTime? get created_date => _$this._created_date;
  set created_date(DateTime? created_date) =>
      _$this._created_date = created_date;

  String? _bannerImageUrl;
  String? get bannerImageUrl => _$this._bannerImageUrl;
  set bannerImageUrl(String? bannerImageUrl) =>
      _$this._bannerImageUrl = bannerImageUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _gameMasterEmail;
  String? get gameMasterEmail => _$this._gameMasterEmail;
  set gameMasterEmail(String? gameMasterEmail) =>
      _$this._gameMasterEmail = gameMasterEmail;

  ListBuilder<String>? _userEmails;
  ListBuilder<String> get userEmails =>
      _$this._userEmails ??= new ListBuilder<String>();
  set userEmails(ListBuilder<String>? userEmails) =>
      _$this._userEmails = userEmails;

  ListBuilder<DocumentReference<Object?>>? _characters;
  ListBuilder<DocumentReference<Object?>> get characters =>
      _$this._characters ??= new ListBuilder<DocumentReference<Object?>>();
  set characters(ListBuilder<DocumentReference<Object?>>? characters) =>
      _$this._characters = characters;

  String? _setting;
  String? get setting => _$this._setting;
  set setting(String? setting) => _$this._setting = setting;

  String? _rulesUrl;
  String? get rulesUrl => _$this._rulesUrl;
  set rulesUrl(String? rulesUrl) => _$this._rulesUrl = rulesUrl;

  ListBuilder<DocumentReference<Object?>>? _customItems;
  ListBuilder<DocumentReference<Object?>> get customItems =>
      _$this._customItems ??= new ListBuilder<DocumentReference<Object?>>();
  set customItems(ListBuilder<DocumentReference<Object?>>? customItems) =>
      _$this._customItems = customItems;

  ListBuilder<DocumentReference<Object?>>? _aspects;
  ListBuilder<DocumentReference<Object?>> get aspects =>
      _$this._aspects ??= new ListBuilder<DocumentReference<Object?>>();
  set aspects(ListBuilder<DocumentReference<Object?>>? aspects) =>
      _$this._aspects = aspects;

  GameRecordBuilder();

  GameRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gameTitle = $v.gameTitle;
      _id = $v.id;
      _created_date = $v.created_date;
      _bannerImageUrl = $v.bannerImageUrl;
      _description = $v.description;
      _gameMasterEmail = $v.gameMasterEmail;
      _userEmails = $v.userEmails?.toBuilder();
      _characters = $v.characters?.toBuilder();
      _setting = $v.setting;
      _rulesUrl = $v.rulesUrl;
      _customItems = $v.customItems?.toBuilder();
      _aspects = $v.aspects?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GameRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GameRecord;
  }

  @override
  void update(void Function(GameRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GameRecord build() => _build();

  _$GameRecord _build() {
    _$GameRecord _$result;
    try {
      _$result = _$v ??
          new _$GameRecord._(
              gameTitle: gameTitle,
              id: id,
              created_date: created_date,
              bannerImageUrl: bannerImageUrl,
              description: description,
              gameMasterEmail: gameMasterEmail,
              userEmails: _userEmails?.build(),
              characters: _characters?.build(),
              setting: setting,
              rulesUrl: rulesUrl,
              customItems: _customItems?.build(),
              aspects: _aspects?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userEmails';
        _userEmails?.build();
        _$failedField = 'characters';
        _characters?.build();

        _$failedField = 'customItems';
        _customItems?.build();
        _$failedField = 'aspects';
        _aspects?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GameRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
