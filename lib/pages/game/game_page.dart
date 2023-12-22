import 'package:flutter/material.dart';
import 'package:koala/providers/game_provider.dart';
import 'package:koala/widgets/custom/button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final gameRecord = gameProvider.gameRecord;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        gameRecord.gameTitle!,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 200, // Placeholder height for banner image
                      child: Placeholder(), // Replace with actual image widget
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Description text goes here...',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle setting
                          },
                          child: Text('Setting'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle rules
                          },
                          child: Text('Rules'),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Characters',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ...List.generate(3,
                        (index) => CharacterCard()), // Generate character cards
                    ListTile(
                      title: Text('GM KIT'),
                      trailing: Checkbox(
                        value: true, // Bind to state variable
                        onChanged: (bool? value) {
                          // Handle change
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 20, top: 20),
              child: CustomMainButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 30,
                buttonText: "Back",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Character Name'), // Bind to character name
        onTap: () {
          // Handle character tap
        },
      ),
    );
  }
}
