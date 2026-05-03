import 'dart:math';

import 'package:flutter/material.dart';
import 'settings_menu.dart';
import 'select_spaceship.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/stars1.png'), fit: BoxFit.fill)
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Game Logo/Icon
                    Transform.rotate(
                      angle: pi / 3, // 60 degrees
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyan.shade600.withOpacity(0.3),
                              Colors.purple.shade600.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: Image.asset('assets/images/ship_H.png'),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Game Title
                    const Text(
                      'GALAXY STRIKE',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 15,
                            color: Colors.cyan,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.cyan.shade400.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'SPACE SHOOTER',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2,
                          color: Colors.cyan.shade200,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Play Button
                    _buildMenuButton(
                      label: 'PLAY NOW',
                      icon: Icons.play_circle_filled,
                      color: Colors.cyan,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const SelectSpaceship(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Settings Button
                    _buildMenuButton(
                      label: 'SETTINGS',
                      icon: Icons.settings,
                      color: Colors.purple,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsMenu(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 60),

                    // Version
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 250,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: color, width: 2),
          ),
          elevation: 0,
          shadowColor: color.withOpacity(0.5),
        ),
      ),
    );
  }
}