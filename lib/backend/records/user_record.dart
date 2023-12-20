import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'serializers.dart';

part 'user_record.g.dart';

abstract class UserRecord implements Built<UserRecord, UserRecordBuilder> {
  static Serializer<UserRecord> get serializer => _$userRecordSerializer;

  String? get email;
  String? get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'name')
  String? get displayName;

  UserRecord._(); // private constructor

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UserRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  factory UserRecord([void Function(UserRecordBuilder)? updates]) =
      _$UserRecord;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? uid,
  DateTime? createdTime,
  String? displayName,
  // DocumentReference? sets,
}) {
  final firestoreData = serializers.toFirestore(
    UserRecord.serializer,
    UserRecord(
      (u) => u
        ..email = email
        ..uid = uid
        ..createdTime = createdTime
        ..displayName = displayName,
    ),
  );

  return firestoreData;
}
