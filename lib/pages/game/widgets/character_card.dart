import 'package:flutter/material.dart';
import 'package:koala/backend/records/character_record.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/game/game_view.dart';
import 'package:koala/pages/home/widgets/home_dialogs.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/screen_sizes.dart';
import 'package:koala/utils/theme.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

Widget buildCharacterCard(BuildContext context, CharacterRecord character) {
  final gameProvider = Provider.of<GameProvider>(context);

  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 16),
    child: Container(
      height: 60,
      width: ScreenInfo(context).screenWidth * 0.6,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 46, 46, 46),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => GameScreen(),
          //     ));
        },
        onLongPress: () {},
        child: Text(character.name!),
      ),
    ),
  );
}
