import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'serializers.dart';

part 'character_record.g.dart';

abstract class CharacterRecord
    implements Built<CharacterRecord, CharacterRecordBuilder> {
  static Serializer<CharacterRecord> get serializer =>
      _$characterRecordSerializer;

  String? get name;
  String? get id;

  DateTime? get createdDate;
  String? get description;
  String? get imageUrl; // Optional: URL to an image of the character
  Map<String, dynamic>?
      get stats; // A map to hold various stats of the character

  @BuiltValueField(wireName: 'game_id')
  String? get gameId; // The ID of the game this character belongs to

  CharacterRecord._(); // private constructor

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('characters');

  static Stream<CharacterRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CharacterRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  factory CharacterRecord([void Function(CharacterRecordBuilder)? updates]) =
      _$CharacterRecord;

  static CharacterRecord fromFirestore(DocumentSnapshot doc) {
    return serializers.deserializeWith(CharacterRecord.serializer, {
      ...doc.data() as Map<String, dynamic>,
      'createdDate': (doc.data() as Map)['createdDate']?.toDate(),
    })!;
  }

  Map<String, dynamic> createCharacterRecordData({
    String? name,
    DateTime? createdDate,
    String? description,
    String? imageUrl,
    Map<String, dynamic>? stats,
    String? gameId,
  }) {
    final characterRecord = CharacterRecord((b) => b
      ..name = name
      ..createdDate = createdDate
      ..description = description
      ..imageUrl = imageUrl
      ..stats = stats
      ..gameId = gameId);

    final firestoreData = serializers.toFirestore(
      CharacterRecord.serializer,
      characterRecord,
    );

    return firestoreData;
  }
}
