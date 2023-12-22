import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

final storage = GetStorage();

class DiceProvider extends ChangeNotifier {
  late bool _narrativeDice;

  DiceProvider() {
    _initDice();
  }

  void _initDice() {
    _narrativeDice = storage.read('narrative_dice');
  }

  bool get narrativeDice => _narrativeDice;

  void toggleDiceMode() {
    _narrativeDice = !_narrativeDice;
    storage.write("narrative_dice", _narrativeDice);
    notifyListeners();
  }
}
