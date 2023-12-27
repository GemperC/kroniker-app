import 'package:flutter/material.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/game/game_view.dart';
import 'package:koala/pages/home/widgets/home_dialogs.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/utils/theme.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:stroke_text/stroke_text.dart';

Widget buildGameCard(BuildContext context, GameRecord game) {
  final gameProvider = Provider.of<GameProvider>(context);

  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 16),
    child: Container(
      height: 150,
      decoration: game.bannerImageUrl != null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(game.bannerImageUrl!)))
          : BoxDecoration(
              color: Color.fromARGB(255, 46, 46, 46),
              borderRadius: BorderRadius.circular(20),
            ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(),
              ));
          gameProvider.toggleGame(game);
        },
        onLongPress: () {
          showDeleteGameDialog(context, game);
        },
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8),
            child: StrokeText(
              text: game.gameTitle ?? 'Unknown Game',
              textStyle: AppTypography.gameCardText(context),
              strokeColor: Colors.black,
              strokeWidth: 4,
              textColor: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
