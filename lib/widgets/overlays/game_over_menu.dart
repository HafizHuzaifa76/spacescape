import 'dart:ui';

import 'package:flutter/material.dart';
import '../../game/game.dart';
import '../../screens/main_menu.dart';
import 'pause_button.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final SpacescapeGame game;
  final int? score;
  final int? highScore;

  const GameOverMenu({
    super.key,
    required this.game,
    this.score,
    this.highScore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        width: MediaQuery.of(context).size.width * 0.8,
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.purple.shade800,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Game Over Text
                Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.grey.shade800,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // Score Display
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'YOUR SCORE',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white60,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${score ?? 0}',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade400,
                        ),
                      ),
                      if (highScore != null && score != null) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emoji_events, color: Colors.amber, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'BEST: $highScore',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildSciFiButton(
                        label: 'REPLAY',
                        icon: Icons.refresh,
                        color: Colors.blue,
                        onPressed: () {
                          game.overlays.remove(GameOverMenu.id);
                          game.overlays.add(PauseButton.id);
                          game.reset();
                          game.resumeEngine();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildSciFiButton(
                        label: 'EXIT',
                        icon: Icons.exit_to_app,
                        color: Colors.purple,
                        onPressed: () {
                          game.overlays.remove(GameOverMenu.id);
                          game.reset();
                          game.resumeEngine();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const MainMenu()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSciFiButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.5)],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}