import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'serializers.dart';
import 'package:built_collection/built_collection.dart';

part 'game_record.g.dart';

abstract class GameRecord implements Built<GameRecord, GameRecordBuilder> {
  static Serializer<GameRecord> get serializer => _$gameRecordSerializer;

  String? get gameTitle;
  String? get id;

  DateTime? get created_date;
  String? get bannerImageUrl;
  String? get description;
  String? get gameMasterEmail;
  List<String>? get userEmails;
  BuiltList<DocumentReference>? get characters;
  String? get setting;
  String? get rulesUrl;
  BuiltList<DocumentReference>? get customItems;
  BuiltList<DocumentReference>? get aspects;

  GameRecord._(); // private constructor

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('games');

  static Stream<GameRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<GameRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  factory GameRecord([void Function(GameRecordBuilder)? updates]) =
      _$GameRecord;

  static GameRecord fromFirestore(DocumentSnapshot doc) {
    return serializers.deserializeWith(GameRecord.serializer, {
      ...doc.data() as Map<String, dynamic>,
      'created_date': (doc.data() as Map)['created_date']?.toDate(),
      // Repeat this for other DateTime fields if necessary
    })!;
  }

  Map<String, dynamic> createGameRecordData({
    String? gameTitle,
    DateTime? createdDate,
    String? bannerImageUrl,
    String? description,
    String? gameMasterEmail,
    BuiltList<String>? userEmails,
    BuiltList<DocumentReference>? characters,
    String? setting,
    String? rulesUrl,
    BuiltList<DocumentReference>? customItems,
    BuiltList<DocumentReference>? aspects,
  }) {
    final gameRecord = GameRecord((b) => b
      ..gameTitle = gameTitle
      ..created_date = createdDate
      ..bannerImageUrl = bannerImageUrl
      ..description = description
      ..gameMasterEmail = gameMasterEmail
      ..userEmails = userEmails?.toList()
      ..characters = characters?.toBuilder()
      ..setting = setting
      ..rulesUrl = rulesUrl
      ..customItems = customItems?.toBuilder()
      ..aspects = aspects?.toBuilder());

    final firestoreData = serializers.toFirestore(
      GameRecord.serializer,
      gameRecord,
    );

    return firestoreData;
  }

  void addNewGame(Map<String, dynamic> gameData) async {
  try {
    DocumentReference docRef = GameRecord.collection.doc();

    gameData['id'] = docRef.id;

    await docRef.set(gameData);
    print('New game added with ID: ${docRef.id}');
  } catch (e) {
    print('Error adding game: $e');
  }
}
}
