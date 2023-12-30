import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:koala/backend/records/game_record.dart';
import 'package:koala/pages/game/game_logic.dart';
import 'package:koala/utils/screen_sizes.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

void showRulesDialog(BuildContext context, GameRecord gameRecord, bool isGM) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(20),
        title: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text('Rules'),
              if (isGM)
                Align(
                  alignment: Alignment(1, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      uploadPDF(context, gameRecord.id!);
                    },
                    child: Text('Add PDF'),
                  ),
                )
            ],
          ),
        ),
        content: SizedBox(
          height: ScreenInfo(context).screenHeight,
          width: ScreenInfo(context).screenWidth,
          child: gameRecord.rulesUrl != null
              ? PDF(fitEachPage: true).cachedFromUrl(
                  gameRecord.rulesUrl!,
                  placeholder: (progress) => Center(child: Text('$progress %')),
                  errorWidget: (error) => Center(child: Text(error.toString())),
                )
              : Center(child: Text("No PDF available")),
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
