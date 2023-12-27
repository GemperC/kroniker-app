import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koala/backend/auth/auth_util.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:provider/provider.dart';

final storage = GetStorage();

class GameProvider extends ChangeNotifier {
  GameRecord? _gameRecord;
  bool _isGM = false;

  GameRecord get gameRecord => _gameRecord!;
  bool get isGM => _isGM!;

  void toggleGame(GameRecord gameRecord) {
    _gameRecord = gameRecord;
    if (currentUserDocument!.email == gameRecord.gameMasterEmail) {
      _isGM = true;
    } else
      _isGM = false;
    notifyListeners();
  }

  void updateGameBannerUrl(String newImageUrl) {
    if (_gameRecord != null) {
      _gameRecord =
          _gameRecord!.rebuild((b) => b..bannerImageUrl = newImageUrl);
      notifyListeners();
    }
  }

  void updateGameDescription(String newDescription) {
    if (_gameRecord != null) {
      _gameRecord =
          _gameRecord!.rebuild((b) => b..description = newDescription);
      notifyListeners();
    }
  }

  void updateGameTitle(String newGameTitle) {
    if (_gameRecord != null) {
      _gameRecord = _gameRecord!.rebuild((b) => b..gameTitle = newGameTitle);
      notifyListeners();
    }
  }

  // void updateGameCharacters(List<DocumentReference> characerList) {
  //   if (_gameRecord != null) {
  //     _gameRecord = _gameRecord!.rebuild((b) => b..characters = characerList);
  //     notifyListeners();
  //   }
  // }
}
