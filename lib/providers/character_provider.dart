import 'package:flutter/material.dart';
import 'package:koala/backend/records/character_record.dart';

class CharacterProvider extends ChangeNotifier {
  CharacterRecord? _currentCharacter;

  // Getter to retrieve the current character
  CharacterRecord? get currentCharacter => _currentCharacter;

  // Function to select and set a character
  void selectCharacter(CharacterRecord character) {
    _currentCharacter = character;
    notifyListeners();
  }

  // Function to update character details
  // This can be expanded based on what details you want to update
  void updateCharacterDetails({
    String? name,
    String? description,
    String? imageUrl,
    Map<String, dynamic>? stats,
  }) {
    if (_currentCharacter != null) {
      _currentCharacter = _currentCharacter!.rebuild((b) {
        if (name != null) b.name = name;
        if (description != null) b.description = description;
        if (imageUrl != null) b.imageUrl = imageUrl;
        if (stats != null) b.stats = stats;
      });
      notifyListeners();
    }
  }

  // Add any other methods relevant to your character management here
}
