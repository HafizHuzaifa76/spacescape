import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacescape/widgets/overlays/game_over_menu.dart';

import '../game/game.dart';
import '../models/player_data.dart';
import '../widgets/overlays/pause_button.dart';
import '../widgets/overlays/pause_menu.dart';

// This class represents the actual game screen
// where all the action happens.
class GamePlay extends StatefulWidget {
  const GamePlay({super.key});

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  late final SpacescapeGame _game;

  @override
  void initState() {
    super.initState();
    _game = SpacescapeGame();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _game.syncPlayerData(context.read<PlayerData>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WillPopScope provides us a way to decide if
      // this widget should be poped or not when user
      // presses the back button.
      body: GestureDetector(
        onPanUpdate: (details) {
          _game.movePlayerBySwipe(details.delta);
        },
        child: PopScope(
          canPop: false,
          // GameWidget is useful to inject the underlying
          // widget of any class extending from Flame's Game class.
          child: GameWidget<SpacescapeGame>.controlled(
            gameFactory: () => _game,
            // Initially only pause button overlay will be visible.
            initialActiveOverlays: const [PauseButton.id],
            overlayBuilderMap: {
              PauseButton.id: (BuildContext context, SpacescapeGame game) =>
                  PauseButton(game: game),
              PauseMenu.id: (BuildContext context, SpacescapeGame game) =>
                  PauseMenu(game: game),
              GameOverMenu.id: (BuildContext context, SpacescapeGame game) =>
                  GameOverMenu(game: game),
            },
          ),
        ),
      ),
    );
  }
}
