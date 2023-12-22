import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:provider/provider.dart';

final storage = GetStorage();

class GameProvider extends ChangeNotifier {
  GameRecord? _gameRecord;

  GameRecord get gameRecord => _gameRecord!;

  void toggleGame(GameRecord gameRecord) {
    _gameRecord = gameRecord;
    notifyListeners();
  }
}
