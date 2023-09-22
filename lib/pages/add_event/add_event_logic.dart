import 'dart:io';

import 'package:LuxCal/pages/add_event/add_event_model.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/auth/auth_util.dart';
import '../../backend/records/event_record.dart';
import '../../utils/utils.dart';
import 'event.dart';



Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<String> uploadImageToFirebase(File imageFile, String eventID) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('events/$eventID.png');
  UploadTask uploadTask = ref.putFile(imageFile);
  await uploadTask.whenComplete(() {});
  String downloadUrl = await ref.getDownloadURL();
  return downloadUrl;
}

createEvent(AddEventModel _model, onAddEvet) async {
  if (!Utils.isFormValidated(_model.formKey)) return;

  _model.formKey.currentState?.save();

  final event = CalendarEventData<Event>(
    date: _model.startDate,
    color: _model.color,
    endTime: _model.endTime,
    startTime: _model.startTime,
    description: _model.description,
    endDate: _model.endDate,
    title: _model.title,
    event: Event(
      title: _model.title,
    ),
  );

  onAddEvet?.call(event);

  // CalendarControllerProvider.of(context).controller.add(event);

  Map<String, dynamic> eventData = createEventRecordData(
      title: event.title,
      startdate: event.date,
      color: Utils.getColorString(event.color.toString()),
      created_date: DateTime.now(),
      enddate: event.endDate,
      endtime: event.endTime,
      starttime: event.startTime,
      description: event.description,
      event_creator: currentUserDocument!.uid);

  DocumentReference eventRef = await EventRecord.collection.add(eventData);

  if (_model.selectedImage != null) {
    _model.imageUrl =
        await uploadImageToFirebase(_model.selectedImage!, eventRef.id);
  }
  eventRef.update({"imageUrl": _model.imageUrl});

  resetForm(_model);
}

void resetForm(AddEventModel _model) {
  _model.formKey.currentState?.reset();
}